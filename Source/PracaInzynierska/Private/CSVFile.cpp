// Fill out your copyright notice in the Description page of Project Settings.


#include "CSVFile.h"
#include "Misc/FileHelper.h"
#include "HAL/PlatformFilemanager.h"

bool UCSVFile::SaveArrayText(FString SaveDirectory, FString FileName, TArray<FString>SaveText, bool AllowOverWritting = false) {
	// Set complete 
	SaveDirectory += "\\"; SaveDirectory += FileName;

	if (!AllowOverWritting) {
		if (FPlatformFileManager::Get().GetPlatformFile().FileExists(*SaveDirectory)) {
			return false;
		}
	}
	FString FinalString = "";

	for (FString& Each : SaveText) {
		FinalString += Each;
		FinalString += LINE_TERMINATOR;
	}

	return FFileHelper::SaveStringToFile(FinalString, *SaveDirectory);
}

