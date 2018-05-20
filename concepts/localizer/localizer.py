#! /usr/bin/env python

import glob
import re
import os
import argparse
from enum import Enum


# CLI arguments
class CLIargs:
    saveDir = "./"


# Base localization extracting
def performBaseLocalizationExtracting():
    localizations = parseLocalizations()
    writeLocalizationsToFile(localizations)


def parseLocalizations():
    regexpString = '(\".*\")\.localized\(\s*key:\s*(\"[^"]*\")\)?(,\s*comment:\s*(\"[^"]*\")\))?'
    regexp = re.compile(regexpString)

    for filename in glob.iglob('./**/*.swift', recursive = True):
        localizations = []
        with open(filename, encoding='utf-8') as file:
            fileContent = file.read()
            localization = regexp.findall(fileContent)
            localizations.append(localization)
        return localizations


def getFilepathForLocalizationFile():
    filepath = ""
    filename = "Localizable.strings"
    if CLIargs.saveDir.endswith("/"):
        filepath = CLIargs.saveDir + filename
    else:
        filepath = CLIargs.saveDir + '/' + filename
    return filepath


def writeLocalizationsToFile(localizations):
    filepath = getFilepathForLocalizationFile()

    oldLocalizations = []
    if os.path.exists(filepath):
        # Backup original file
        print("Old Localizable.strings file has been backed up to Localizable.strings.bak")
        os.system('cp %s %s.bak' % (filepath, filepath))

        # extract old localizations
        with open(filepath, "r", encoding='utf-8') as file:
            fileContent = file.read()
            regexpString = '^(\"[^\"]*\")'
            regexp = re.compile(regexpString, re.MULTILINE)
            foundedOldLocalizations = regexp.findall(fileContent)
            for locale in foundedOldLocalizations:
                oldLocalizations.append(locale)

    # Write to file base localizations
    print("New localizations:")
    isNewLocalizationsDetected = False
    with open(filepath, "w+", encoding='utf-8') as file:
        for localization in localizations:
            for locale in localization:
                localeBaseString = locale[0]
                localeKey = locale[1]
                localeComment = locale[3]
                if localeComment:
                    file.write("/* {0} */\n".format(localeComment))
                else:
                    file.write("/* No comment provided by engineer */\n")
                file.write("{0} = {1};\n\n".format(localeKey, localeBaseString))

                if localeKey not in oldLocalizations:
                    isNewLocalizationsDetected = True
                    print(localeKey)
    if not isNewLocalizationsDetected:
        print("There is no new localizations ..")

# CLI arguments setup & handling
def setupCLIarguments():
    argParser = argparse.ArgumentParser(description="The helper tool for extracting base localization file from swift source code files")

    argParser.add_argument("-d",
                           help="Directory for saving the base localization file. Default is current directory.",
                           dest="saveDir",
                           type=str,
                           default=CLIargs.saveDir)

    argParser.set_defaults(func=handleArguments)
    args = argParser.parse_args()
    args.func(args)


def handleArguments(args):
    CLIargs.saveDir = args.saveDir


# Main
def main():
    setupCLIarguments()
    performBaseLocalizationExtracting()


if __name__ == "__main__":
    main()
