// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "CSVFile.generated.h"

/**
 * 
 */
UCLASS()
class PRACAINZYNIERSKA_API UCSVFile : public UBlueprintFunctionLibrary{
	GENERATED_BODY()

	UFUNCTION(BlueprintCallable, Category = "Custom", meta = (Keywords = "Save"))
	static bool SaveArrayText(FString SaveDirectory, FString FileName, TArray<FString>SaveText, bool AllowOverWritting);
	
};
