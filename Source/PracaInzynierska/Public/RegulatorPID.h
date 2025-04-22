// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "RegulatorPID.generated.h"

/**
 *
 */
USTRUCT(BlueprintType)
struct Fsterowanie {
	GENERATED_BODY()

		UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Fsterowanie")
		float przepustnica;
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Fsterowanie")
		float hamulec;
};

UCLASS()
class PRACAINZYNIERSKA_API URegulatorPID : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

		UFUNCTION(BlueprintCallable, Category = "Custom", meta = (Keywords = "Regulator"))
		static Fsterowanie Regulator(float Wzad, float Pomiar, float Kp, float Ti, float Td, float Ts);

};
