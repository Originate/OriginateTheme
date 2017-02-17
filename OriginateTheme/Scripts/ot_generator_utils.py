import os

def upcaseFirstLetter(s):
    """
        Method which upercases the first letter of a string.

        Parameters
        -----------
        s: String
            String whose first letter should be upercase.
    """
    return s[0].upper() + s[1:] if s else s

def indent(string, numSpaces):
    """
        Indents every line of text in string

        Parameters
        -----------
        string: String
            The string to indent
        numSpaces: Integer
            Amount of spaces to indent by
    """
    return  '\n'.join([("".rjust(numSpaces)+s).rstrip() for s in string.split('\n')])

######################
##### File Utils #####
######################

def saveFile(outputDirectory, fileName, fileContent):
    filePath = outputDirectory + fileName
    if os.path.isfile(filePath):
        os.chmod(filePath, 0755)
    with open(filePath, 'wb') as outputFile:
        outputFile.write(fileContent)
