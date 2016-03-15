//
//  FileUtils.m
//  TripleJackPokerGame
//
//  Created by Udit on 1/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//
//------------------------------------------------------------------------------------------
#pragma mark - Project Imports
//------------------------------------------------------------------------------------------

#import "FileUtils.h"

//------------------------------------------------------------------------------------------
#pragma mark - HashDefines
//------------------------------------------------------------------------------------------

#define FU_DEBUG                1
#define FU_LOG(__X__)           if(FU_DEBUG == 1){__X__}

//------------------------------------------------------------------------------------------
#pragma mark - Private
//------------------------------------------------------------------------------------------

@interface FileUtils()

@end

//------------------------------------------------------------------------------------------
#pragma mark - Implementation
//------------------------------------------------------------------------------------------

@implementation FileUtils

//------------------------------------------------------------------------------------------
#pragma mark - ClassMethods
//------------------------------------------------------------------------------------------

+ (void)copyFile:(NSString*)lstrFileNameSrc toFile:(NSString*)lstrFileNameDest
{
    NSError* lobjError = nil;
    
    if ([FileUtils isFilePresent:lstrFileNameDest])
    {
        [[NSFileManager defaultManager] removeItemAtPath:[FileUtils pathForFileName:lstrFileNameDest]
                                                   error:&lobjError];
    }
    
    if (lobjError == nil)
    {
        [[NSFileManager defaultManager] copyItemAtPath:[FileUtils pathForFileName:lstrFileNameSrc]
                                                toPath:[FileUtils pathForFileName:lstrFileNameDest]
                                                 error:&lobjError];
        
        if (lobjError)
        {
            NSLog(@"ERROR : Failed to copy file %@ to file %@ with error : %@", lstrFileNameSrc, lstrFileNameDest, [lobjError description]);
        }
    }
    else
    {
        NSLog(@"ERROR : Failed to deleting file %@ with error : %@", lstrFileNameDest, [lobjError description]);
    }
}

+ (NSArray*)filesWithName:(NSString*)lstrFileName
{
    NSMutableArray* larrayFiles = [NSMutableArray arrayWithCapacity:10];
    
    NSInteger index = 0;
    
    NSString* lstrOriginalFileName = [NSString stringWithString:lstrFileName];
    
    NSString* lstrExtension = [lstrOriginalFileName pathExtension];
    
    NSString* lstrStringForIteration = [NSString stringWithString:lstrFileName];
    
    while ([FileUtils isFilePresent:lstrStringForIteration])
    {
        [larrayFiles addObject:lstrStringForIteration];
        
        NSString* lstrFileNameWithoutExtension = [lstrOriginalFileName stringByDeletingPathExtension];
        
        lstrStringForIteration = [lstrFileNameWithoutExtension stringByAppendingFormat:@"-%ld", (long)index];
        
        lstrStringForIteration = [lstrStringForIteration stringByAppendingPathExtension:lstrExtension];
        
        index++;
    }
    
    return [NSArray arrayWithArray:larrayFiles];
}

+ (BOOL)isFilePresent:(NSString*)lstrFileName
{
    NSString* lstrPathForFileName = [FileUtils pathForFileName:lstrFileName];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:lstrPathForFileName];
}

+ (BOOL)isFilePresentInDocsDirectory:(NSString*)lstrFileName
{
    NSString* lstrPathForFileName = [FileUtils pathForFileNameInDocsDirectory:lstrFileName];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:lstrPathForFileName];
}

+ (NSString*)docsDirectory
{
    NSArray* larrayPaths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    NSString* lstrDocumentDirectoryPath =
    [larrayPaths objectAtIndex:0];
    
    return lstrDocumentDirectoryPath;
}

+ (NSString*)pathForFileName:(NSString*)lstrFileName
{
    NSString* lstrFilePathToReturn = nil;
    
    if (lstrFileName)
    {
        NSString* lstrPathForFileInDocsDirectory = [FileUtils pathForFileNameInDocsDirectory:lstrFileName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:lstrPathForFileInDocsDirectory])
        {
            lstrFilePathToReturn = lstrPathForFileInDocsDirectory;
        }
        else
        {
            lstrFilePathToReturn = [[NSBundle mainBundle] pathForResource:lstrFileName ofType:nil];
        }
    }
    else
    {
        NSLog(@"ERROR : lstrFileName is nil");
    }
    
    return lstrFilePathToReturn;
    
    //    if([UserSettings shouldUseDocsDirectory])
    //    {
    //        NSString* lstrDocumentDirectoryPath = [FileUtils docsDirectory];
    //        return [lstrDocumentDirectoryPath stringByAppendingPathComponent:lstrFileName];
    //    }
    //    else
    //    {
    //        return [[NSBundle mainBundle] pathForResource:lstrFileName ofType:nil];
    //    }
}

+ (NSString*)pathForFileNameInDocsDirectory:(NSString*)lstrFileName
{
    NSString* lstrDocumentDirectoryPath = [FileUtils docsDirectory];
    return [lstrDocumentDirectoryPath stringByAppendingPathComponent:lstrFileName];
}

+ (NSString*)writePathForFileName:(NSString*)lstrFileName
{
    return [[FileUtils docsDirectory] stringByAppendingPathComponent:lstrFileName];
}

+ (void)deleteFileInDocsDirectory:(NSString*)lstrFileName
{
    NSString* lstrDocsDirectory = [FileUtils docsDirectory];
    NSString* lstrResourceLocation = [lstrDocsDirectory stringByAppendingPathComponent:lstrFileName];
    
    NSError* lobjError = nil;
    [[NSFileManager defaultManager] removeItemAtPath:lstrResourceLocation error:&lobjError];
    
    if (lobjError)
    {
        NSLog(@"Failed To Remove : %@", [lstrFileName lastPathComponent]);
    }
    else
    {
        NSLog(@"Successfully Removed : %@", [lstrFileName lastPathComponent]);
    }
}

+ (void)deleteAllFilesInDocsDirectory
{
    NSString* lstrDocsDirectory = [FileUtils docsDirectory];
    
    NSArray* larrayPathsForItemsInDirectory = [[NSFileManager defaultManager] subpathsAtPath:lstrDocsDirectory];
    
    for (NSString* lstrFilePath in larrayPathsForItemsInDirectory)
    {
        NSError* lobjError = nil;
        
        NSString* lstrResourceLocation = [lstrDocsDirectory stringByAppendingPathComponent:lstrFilePath];
        
        [[NSFileManager defaultManager] removeItemAtPath:lstrResourceLocation error:&lobjError];
        
        if (lobjError)
        {
            NSLog(@"Failed To Remove : %@", [lstrFilePath lastPathComponent]);
        }
        else
        {
            NSLog(@"Successfully Removed : %@", [lstrFilePath lastPathComponent]);
        }
    }
}

+ (void)deleteAllFilesInDocsDirectoryExcept:(NSString*)lstrFilePathNotToDelete
{
    NSString* lstrDocsDirectory = [FileUtils docsDirectory];
    
    NSArray* larrayPathsForItemsInDirectory = [[NSFileManager defaultManager] subpathsAtPath:lstrDocsDirectory];
    
    for (NSString* lstrFilePath in larrayPathsForItemsInDirectory)
    {
        if ([lstrFilePath isEqualToString:lstrFilePathNotToDelete] == NO)
        {
            NSError* lobjError = nil;
            
            NSString* lstrResourceLocation = [lstrDocsDirectory stringByAppendingPathComponent:lstrFilePath];
            
            [[NSFileManager defaultManager] removeItemAtPath:lstrResourceLocation error:&lobjError];
            
            if (lobjError)
            {
                NSLog(@"Failed To Remove : %@", [lstrFilePath lastPathComponent]);
            }
            else
            {
                NSLog(@"Successfully Removed : %@", [lstrFilePath lastPathComponent]);
            }
        }
        else
        {
            NSLog(@"Not Removed : %@", [lstrFilePath lastPathComponent]);
        }
    }
}

+ (NSDictionary*)dictionaryFromFile:(NSString*)lstrFileName
{
    NSString* lstrFilePath = [FileUtils pathForFileName:lstrFileName];
    return [NSDictionary dictionaryWithContentsOfFile:lstrFilePath];
}

//------------------------------------------------------------------------------------------
#pragma mark - Library and Document Directory Methods
//------------------------------------------------------------------------------------------

+ (NSString*)strPathLibDirectory
{
    NSString* lstrLibraryDirectoryPathToReturn = nil;
    
    lstrLibraryDirectoryPathToReturn =
    [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    return lstrLibraryDirectoryPathToReturn;
}

+ (NSString*)strPathDocsDirectory
{
    NSArray* larrayPaths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    NSString* lstrDocumentDirectoryPath =
    [larrayPaths objectAtIndex:0];
    
    return lstrDocumentDirectoryPath;
}

+ (NSString*)strLibPathForDirectory:(NSString*)lstrDirectoryName
{
    NSString* lstrImageDirectoryPathToReturn = nil;
    
    NSString* lstrLibraryDirectoryPath = [FileUtils strPathLibDirectory];
    
    lstrImageDirectoryPathToReturn = [lstrLibraryDirectoryPath
                                      stringByAppendingPathComponent:lstrDirectoryName];
    
    return lstrImageDirectoryPathToReturn;
}

+ (NSString*)strDocPathForDirectory:(NSString*)lstrDirectoryName
{
    NSString* lstrImageDirectoryPathToReturn = nil;
    
    NSString* lstrLibraryDirectoryPath = [FileUtils strPathDocsDirectory];
    
    lstrImageDirectoryPathToReturn = [lstrLibraryDirectoryPath
                                      stringByAppendingPathComponent:lstrDirectoryName];
    
    return lstrImageDirectoryPathToReturn;
}

+ (void)createDirectory:(NSString*)lstrDirectoryNameToCreate
        inDirectoryPath:(NSString*)lstrSuperDirectoryPath
{
    BOOL lbisDirectoryAlreadyPresent;
    
    NSString *lstrDirectoryPath = [lstrSuperDirectoryPath stringByAppendingPathComponent:lstrDirectoryNameToCreate];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:lstrDirectoryPath isDirectory:&lbisDirectoryAlreadyPresent]
        || !lbisDirectoryAlreadyPresent)
    {
        NSError *error = nil;
        
        [[NSFileManager defaultManager] createDirectoryAtPath:lstrDirectoryPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        if (error)
        {
            NSLog(@"Error creating directory path: %@", [error localizedDescription]);
        }
    }
    else
    {
        NSLog(@"'%@' directory already present in Library Directory", lstrDirectoryNameToCreate);
    }
}

+ (NSArray*)arrayFilesInDirectory:(NSString*)lstrDirectoryName
{
    NSFileManager *lobjFileManager = [NSFileManager defaultManager];
    
    NSString *lstrPathDirectory = [FileUtils strLibPathForDirectory:lstrDirectoryName];
    
    NSError *lobjError = nil;
    
    NSArray *larrayFiles= [lobjFileManager contentsOfDirectoryAtPath:lstrPathDirectory
                                                               error:&lobjError];
    if (lobjError)
    {
        NSLog(@"Error :%@", [lobjError description]);
    }
    
    return larrayFiles;
}

+ (NSString*)strLibPathForFile:(NSString*)lstrFileName
                   inDirectory:(NSString*)lstrDirectoryName
{
    NSString* lstrNewFilePath = nil;
    
    lstrNewFilePath = [[FileUtils strLibPathForDirectory:lstrDirectoryName]
                       stringByAppendingPathComponent:lstrFileName];
    
    return lstrNewFilePath;
}

+ (NSString*)strDocsPathForFile:(NSString*)lstrFileName
                    inDirectory:(NSString*)lstrDirectoryName
{
    NSString* lstrNewFilePath = nil;
    
    lstrNewFilePath = [[FileUtils strDocPathForDirectory:lstrDirectoryName]
                       stringByAppendingPathComponent:lstrFileName];
    
    return lstrNewFilePath;
}

+ (void)saveImageInLib:(UIImage*)lobjImage
              withName:(NSString*)lstrImageName
         directoryName:(NSString*)lstrDirectoryName
{
    NSString *lstrFilePath = [FileUtils  strLibPathForFile:lstrImageName
                                               inDirectory:lstrDirectoryName];
    [FileUtils saveImage:lobjImage
                  toPath:lstrFilePath];
}

+ (UIImage*)retrieveImageInLibWithName:(NSString*)lstrImageName
                         directoryName:(NSString*)lstrDirectoryName
{
    NSString *lstrDirectoryPath = [FileUtils strLibPathForDirectory:lstrDirectoryName];
    
    UIImage *lobjImage = [FileUtils retrieveImage:lstrImageName
                                         fromPath:lstrDirectoryPath];
    
    return lobjImage;
}

+ (void)saveImageInDocumentDir:(UIImage*)lobjImage
                      withName:(NSString*)lstrImageName
                 directoryName:(NSString*)lstrDirectoryName
{
    NSString *lstrFilePath = [FileUtils  strDocsPathForFile:lstrImageName
                                                inDirectory:lstrDirectoryName];
    [FileUtils saveImage:lobjImage
                  toPath:lstrFilePath];
}

+ (UIImage*)retrieveImageFromDocumentDirWithName:(NSString*)lstrImageName
                                   directoryName:(NSString*)lstrDirectoryName
{
    NSString *lstrDirectoryPath = [FileUtils strDocPathForDirectory:lstrDirectoryName];
    
    UIImage *lobjImage = [FileUtils retrieveImage:lstrImageName
                                         fromPath:lstrDirectoryPath];
    
    return lobjImage;
}

//---------------------------------------------------------------------------------
#pragma mark - Saving and Retrieving Methods
//---------------------------------------------------------------------------------

+ (void)saveImage:(UIImage*)lobjImage
           toPath:(NSString*)lstrDirectoryPath
{
    NSData *lobjImageData = UIImagePNGRepresentation(lobjImage);
    
    if (![lobjImageData writeToFile:lstrDirectoryPath atomically:YES])
    {
        NSLog(@"Could Not save Image:%@ at Path :%@", lobjImage, lstrDirectoryPath);
    }
    else
    {
        // do nothing
    }
}

+ (UIImage*)retrieveImage:(NSString*)lstrImageName
                 fromPath:(NSString*)lstrPath
{
    NSString* lstrImagePath = [lstrPath stringByAppendingPathComponent:lstrImageName];
    
    UIImage *lobjImage = [UIImage imageWithContentsOfFile:lstrImagePath];
    
    return lobjImage;
}

//------------------------------------------------------------------------------------------
#pragma mark - Bundle Methods
//------------------------------------------------------------------------------------------

+ (BOOL)isFilePresentInBundle:(NSString*)lstrFileName
{
    NSString* lstrPathForFileName = [FileUtils strPathBundleForFileName:lstrFileName];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:lstrPathForFileName];
}

+ (NSString*)strPathBundleForFileName:(NSString*)lstrFileName
{
    return [[NSBundle mainBundle] pathForResource:lstrFileName ofType:nil];
}

+ (UIImage*)retrieveImageFromMainBundleForFileName:(NSString*)lstrFileName
{
    NSString* lstrImagePath =
    [FileUtils strPathBundleForFileName:lstrFileName];
    
    UIImage *lobjImage = [UIImage imageWithContentsOfFile:lstrImagePath];
    
    return lobjImage;
}

//------------------------------------------------------------------------------------------
@end
//------------------------------------------------------------------------------------------