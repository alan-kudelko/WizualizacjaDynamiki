// Fill out your copyright notice in the Description page of Project Settings.


#include "RegulatorPID.h"
#include "Misc/FileHelper.h"
#include "HAL/PlatformFilemanager.h"

Fsterowanie URegulatorPID::Regulator(float Wzad, float Pomiar, float Kp, float Ti, float Td, float Ts) {
	static struct Fsterowanie w { 0 };

	static float cumError = 0;
	static float control_u = 0;
	static float deError = 0;
	static float eN1 = 0;
	static float eN0 = 0;

	eN1 = Wzad - Pomiar;
	deError = (eN1 - eN0) / Ts;

	control_u = Kp *( eN1 + cumError + Td * deError);


	if (control_u > 1) {
		control_u = 1;
		cumError = control_u / Kp - eN1 - Td * deError;
	}
	if (control_u < -1) {
		control_u = -1;
		cumError = control_u / Kp - eN1 - Td * deError;
	}
	else {
		cumError += Ts * eN1 * Ti;
	}

	if (control_u > 0) {
		w.przepustnica = control_u;
		w.hamulec = 0;
	}
	if (control_u < 0) {
		w.hamulec = -control_u;
		w.przepustnica = 0;
	}
	eN0 = eN1;

	return w;
}