//
//  FileUtils.h
//  TripleJackPokerGame
//
//  Created by Udit on 1/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//------------------------------------------------------------------------------------------
#pragma mark - SDK Imports
//------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>

//------------------------------------------------------------------------------------------
#pragma mark - Interface
//------------------------------------------------------------------------------------------

@interface FileUtils : NSObject

//------------------------------------------------------------------------------------------
#pragma mark - ClassMethods
//------------------------------------------------------------------------------------------

+ (void)copyFile:(NSString*)lstrFileName toFile:(NSString*)lstrFileName;
+ (NSArray*)filesWithName:(NSString*)lstrFileName;
+ (BOOL)isFilePresent:(NSString*)lstrFileName;
+ (BOOL)isFilePresentInDocsDirectory:(NSString*)lstrFileName;
+ (NSString*)docsDirectory;
+ (NSString*)pathForFileName:(NSString*)lstrFileName;
+ (NSString*)pathForFileNameInDocsDirectory:(NSString*)lstrFileName;
+ (NSString*)writePathForFileName:(NSString*)lstrFileName;
+ (void)deleteFileInDocsDirectory:(NSString*)lstrFileName;
+ (void)deleteAllFilesInDocsDirectory;
+ (void)deleteAllFilesInDocsDirectoryExcept:(NSString*)lstrFilePathNotToDelete;
+ (NSDictionary*)dictionaryFromFile:(NSString*)lstrFileName;

//------------------------------------------------------------------------------------------
#pragma mark - Library and Document Directory Methods
//------------------------------------------------------------------------------------------

+ (NSString*)strPathLibDirectory;
+ (NSString*)strPathDocsDirectory;

+ (NSString*)strLibPathForDirectory:(NSString*)lstrDirectoryName;
+ (NSString*)strDocPathForDirectory:(NSString*)lstrDirectoryName;

+ (void)createDirectory:(NSString*)lstrDirectoryNameToCreate
        inDirectoryPath:(NSString*)lstrSuperDirectoryPath;

+ (NSArray*)arrayFilesInDirectory:(NSString*)lstrDirectoryName;

+ (NSString*)strLibPathForFile:(NSString*)lstrFileName
                   inDirectory:(NSString*)lstrDirectoryName;
+ (NSString*)strDocsPathForFile:(NSString*)lstrFileName
                    inDirectory:(NSString*)lstrDirectoryName;

+ (void)saveImageInLib:(UIImage*)lobjImage
              withName:(NSString*)lstrImageName
         directoryName:(NSString*)lstrDirectoryName;

+ (UIImage*)retrieveImageInLibWithName:(NSString*)lstrImageName
                         directoryName:(NSString*)lstrDirectoryName;

+ (void)saveImageInDocumentDir:(UIImage*)lobjImage
                      withName:(NSString*)lstrImageName
                 directoryName:(NSString*)lstrDirectoryName;

+ (UIImage*)retrieveImageFromDocumentDirWithName:(NSString*)lstrImageName
                                   directoryName:(NSString*)lstrDirectoryName;

//---------------------------------------------------------------------------------
#pragma mark - Saving and Retrieving Methods
//---------------------------------------------------------------------------------

+ (void)saveImage:(UIImage*)lobjImage
           toPath:(NSString*)lstrDirectoryPath;

+ (UIImage*)retrieveImage:(NSString*)lstrImageName
                 fromPath:(NSString*)lstrPath;

//------------------------------------------------------------------------------------------
#pragma mark - Bundle Methods
//------------------------------------------------------------------------------------------

+ (BOOL)isFilePresentInBundle:(NSString*)lstrFileName;

+ (NSString*)strPathBundleForFileName:(NSString*)lstrFileName;

+ (UIImage*)retrieveImageFromMainBundleForFileName:(NSString*)lstrFileName;

//------------------------------------------------------------------------------------------
@end
//------------------------------------------------------------------------------------------
