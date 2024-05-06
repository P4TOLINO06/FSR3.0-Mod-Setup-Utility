// ---- FNV Hash 4a50177cfa15f181

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:14:14 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer sky_system_locals : register(b12)
{
  float3 azimuthEastColor : packoffset(c0);
  float3 azimuthWestColor : packoffset(c1);
  float3 azimuthTransitionColor : packoffset(c2);
  float azimuthTransitionPosition : packoffset(c2.w);
  float3 zenithColor : packoffset(c3);
  float3 zenithTransitionColor : packoffset(c4);
  float4 zenithConstants : packoffset(c5);
  float4 skyPlaneColor : packoffset(c6);
  float4 skyPlaneParams : packoffset(c7);
  float hdrIntensity : packoffset(c8);
  float3 sunColor : packoffset(c8.y);
  float3 sunColorHdr : packoffset(c9);
  float3 sunDiscColorHdr : packoffset(c10);
  float4 sunConstants : packoffset(c11);
  float3 sunDirection : packoffset(c12);
  float3 sunPosition : packoffset(c13);
  float3 cloudBaseMinusMidColour : packoffset(c14);
  float3 cloudMidColour : packoffset(c15);
  float3 cloudShadowMinusBaseColourTimesShadowStrength : packoffset(c16);
  float4 cloudDetailConstants : packoffset(c17);
  float4 cloudConstants1 : packoffset(c18);
  float4 cloudConstants2 : packoffset(c19);
  float4 smallCloudConstants : packoffset(c20);
  float3 smallCloudColorHdr : packoffset(c21);
  float4 effectsConstants : packoffset(c22);
  float horizonLevel : packoffset(c23);
  float3 speedConstants : packoffset(c23.y);
  float starfieldIntensity : packoffset(c24);
  float3 moonDirection : packoffset(c24.y);
  float3 moonPosition : packoffset(c25);
  float moonIntensity : packoffset(c25.w);
  float3 lunarCycle : packoffset(c26);
  float3 moonColor : packoffset(c27);
  float noiseFrequency : packoffset(c27.w);
  float noiseScale : packoffset(c28);
  float noiseThreshold : packoffset(c28.y);
  float noiseSoftness : packoffset(c28.z);
  float noiseDensityOffset : packoffset(c28.w);
  float2 noisePhase : packoffset(c29);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float2 v1 : TEXCOORD0,
  uint v2 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyzw
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = -sunPosition.xyz + gViewInverse._m30_m31_m32;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyz = float3(1,0,0) * r0.yzx;
  r1.xyz = r0.zxy * float3(0,1,0) + -r1.xyz;
  r0.w = dot(r1.xy, r1.xy);
  r0.w = rsqrt(r0.w);
  r1.xyz = r1.xyz * r0.www;
  r2.xyz = r1.yzx * r0.zxy;
  r2.xyz = r0.yzx * r1.zxy + -r2.xyz;
  r0.xyz = v0.yyy * r0.xyz;
  r0.xyz = v0.xxx * r1.xyz + r0.xyz;
  r0.xyz = v0.zzz * r2.xyz + r0.xyz;
  r0.xyz = sunPosition.xyz + r0.xyz;
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = v0.wwww * gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r1.xyz = gWorld._m10_m11_m12 * r0.yyy;
  r0.xyw = r0.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r0.xyz = r0.zzz * gWorld._m20_m21_m22 + r0.xyw;
  r0.xyz = v0.www * gWorld._m30_m31_m32 + r0.xyz;
  r0.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.xyz = float3(25000,25000,25000) * r0.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r1.x = sqrt(r0.w);
  r0.w = rsqrt(r0.w);
  r0.xyw = r0.xyz * r0.www;
  r1.y = -globalFogParams[0].x + r1.x;
  r1.y = max(0, r1.y);
  r1.x = r1.y / r1.x;
  r0.z = r1.x * r0.z;
  r1.x = globalFogParams[2].z * r0.z;
  r0.z = cmp(0.00999999978 < abs(r0.z));
  r1.z = -1.44269502 * r1.x;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.x = r1.z / r1.x;
  r0.z = r0.z ? r1.x : 1;
  r1.x = globalFogParams[1].w * r1.y;
  r1.y = -globalFogParams[1].z * r1.y;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r0.z = r1.x * r0.z;
  r0.z = min(1, r0.z);
  r0.z = 1.44269502 * r0.z;
  r0.z = exp2(r0.z);
  r0.z = min(1, r0.z);
  r0.z = 1 + -r0.z;
  o1.w = saturate(globalFogParams[2].y * r0.z);
  r0.z = saturate(dot(r0.xyw, globalFogParams[3].xyz));
  r0.x = saturate(dot(r0.xyw, globalFogParams[4].xyz));
  r0.x = log2(r0.x);
  r0.x = globalFogParams[4].w * r0.x;
  r0.x = exp2(r0.x);
  r0.y = log2(r0.z);
  r0.y = globalFogParams[3].w * r0.y;
  r0.y = exp2(r0.y);
  r1.xzw = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r0.xzw = r0.xxx * r1.xzw + globalFogColorE.xyz;
  r1.xzw = globalFogColor.xyz + -r0.xzw;
  r0.xyz = r0.yyy * r1.xzw + r0.xzw;
  r0.xyz = -globalFogColorN.xyz + r0.xyz;
  o1.xyz = r1.yyy * r0.xyz + globalFogColorN.xyz;
  return;
}