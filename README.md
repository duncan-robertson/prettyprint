# Pascal0 Pretty Printer

This project utilizes an antlr4 to create a parser and lexer for Pascal0. While the parser runs Java is utilized to recreate a given file such that it conforms to a style. See sample before and after files.

To compile the grammer first make sure you have a working antlr installtion, detailed [here](https://github.com/antlr/antlr4/blob/master/doc/getting-started.md)

Run the following to create the program. I recommend doing this in a build directory as many files are generated.

    antlr4 PrettyPrinter.g4
    javac PrettyPrinter*.java

Afterwards the program can be run with grun

    grun PrettyPrinter r sourcefile

Note that this will output the new sourcefile as well as any parser errors to the terminal. The recommended usage is to first check for parser errors

    grun PrettyPrinter r sourcefile 1>/dev/null
    
Then run again to output the new file

    grun PrettyPrinter r sourcefile 2>/dev/null 1>/outputfile
    
Note that this is a single pass program and will not check for errors premptively, and will not necessarily fail if there are source errors. Source files are assumed good. This may cause undesired behvaiour. For example parser errors are consumed, so they will not appear in the new file. This may remove mistakes like extra commas, or it might remove an entire malformed statement. 
