// ---- FNV Hash 340e8c2014bcfec0

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:14 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
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



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  uint v3 : SV_InstanceID0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : SV_Position0,
  out float4 o4 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyzw = v1.xyzw;
  o1.xy = v2.xy;
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.z = r0.w;
  o1.w = 0;
  r1.xyz = -gViewInverse._m30_m31_m32 + v0.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r2.x = sqrt(r1.w);
  r1.w = rsqrt(r1.w);
  r1.xyw = r1.xyz * r1.www;
  r2.y = -globalFogParams[0].x + r2.x;
  r2.y = max(0, r2.y);
  r2.x = r2.y / r2.x;
  r1.z = r2.x * r1.z;
  r2.x = globalFogParams[2].z * r1.z;
  r1.z = cmp(0.00999999978 < abs(r1.z));
  r2.z = -1.44269502 * r2.x;
  r2.z = exp2(r2.z);
  r2.z = 1 + -r2.z;
  r2.x = r2.z / r2.x;
  r1.z = r1.z ? r2.x : 1;
  r2.x = globalFogParams[1].w * r2.y;
  r1.z = r2.x * r1.z;
  r1.z = min(1, r1.z);
  r1.z = 1.44269502 * r1.z;
  r1.z = exp2(r1.z);
  r1.z = min(1, r1.z);
  r1.z = 1 + -r1.z;
  r2.x = -r1.z * globalFogParams[2].y + 1;
  r1.z = globalFogParams[2].y * r1.z;
  r2.z = saturate(dot(r1.xyw, globalFogParams[3].xyz));
  r1.x = saturate(dot(r1.xyw, globalFogParams[4].xyz));
  r1.x = log2(r1.x);
  r1.x = globalFogParams[4].w * r1.x;
  r1.x = exp2(r1.x);
  r1.y = log2(r2.z);
  r1.y = globalFogParams[3].w * r1.y;
  r1.y = exp2(r1.y);
  r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r3.xyz = r1.xxx * r3.xyz + globalFogColorE.xyz;
  r4.xyz = globalFogColor.xyz + -r3.xyz;
  r1.xyw = r1.yyy * r4.xyz + r3.xyz;
  r1.xyw = -globalFogColorN.xyz + r1.xyw;
  r2.z = -globalFogParams[1].z * r2.y;
  r2.y = -globalFogParams[2].x + r2.y;
  r2.y = max(0, r2.y);
  r2.xy = globalFogParams[1].yx * r2.xy;
  r2.y = 1.44269502 * r2.y;
  r2.y = exp2(r2.y);
  r2.y = 1 + -r2.y;
  o2.w = saturate(r2.x * r2.y + r1.z);
  r1.z = 1.44269502 * r2.z;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.xyz = r1.zzz * r1.xyw + globalFogColorN.xyz;
  r3.x = globalFogColor.w + -r1.x;
  r3.y = globalFogColorE.w + -r1.y;
  r3.z = globalFogColorN.w + -r1.z;
  o2.xyz = r2.xxx * r3.xyz + r1.xyz;
  o3.xyzw = r0.xyzw;
  o4.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o4.yzw = float3(0,0,0);
  return;
}