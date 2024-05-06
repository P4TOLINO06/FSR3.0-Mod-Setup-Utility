// ---- FNV Hash 2fa37d9698e8c61b

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

cbuffer im_cbuffer : register(b5)
{
  float4 TexelSize : packoffset(c0);
  float4 refMipBlurParams : packoffset(c1);
  float4 GeneralParams0 : packoffset(c2);
  float4 GeneralParams1 : packoffset(c3);
  float g_fBilateralCoefficient : packoffset(c4);
  float g_fBilateralEdgeThreshold : packoffset(c4.y);
  float DistantCarAlpha : packoffset(c4.z);
  float4 tonemapColorFilterParams0 : packoffset(c5);
  float4 tonemapColorFilterParams1 : packoffset(c6);
  float4 RenderTexMSAAParam : packoffset(c7);
  float4 RenderPointMapINTParam : packoffset(c8);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  out float4 o0 : TEXCOORD0,
  out float3 o1 : TEXCOORD1,
  out float4 o2 : SV_Position0,
  out float4 o3 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xy = v2.xy;
  o0.zw = v0.xy;
  r0.xyz = -gViewInverse._m30_m31_m32 + v0.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = sqrt(r0.w);
  r1.x = -globalFogParams[0].x + r0.w;
  r1.x = max(0, r1.x);
  r1.y = r1.x / r0.w;
  r1.y = r1.y * r0.z;
  r0.x = dot(r0.xyz, -gViewInverse._m20_m21_m22);
  r0.x = GeneralParams1.x * r0.x;
  r0.x = max(1, r0.x);
  r0.y = globalFogParams[2].z * r1.y;
  r0.z = cmp(0.00999999978 < abs(r1.y));
  r1.y = -1.44269502 * r0.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r0.y = r1.y / r0.y;
  r0.y = r0.z ? r0.y : 1;
  r0.z = globalFogParams[1].w * r1.x;
  r1.x = -globalFogParams[2].x + r1.x;
  r1.x = max(0, r1.x);
  r1.x = globalFogParams[1].x * r1.x;
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.y = r0.z * r0.y;
  r0.y = min(1, r0.y);
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = min(1, r0.y);
  r0.y = 1 + -r0.y;
  r0.z = -r0.y * globalFogParams[2].y + 1;
  r0.y = globalFogParams[2].y * r0.y;
  r0.z = globalFogParams[1].y * r0.z;
  r0.y = saturate(r0.z * r1.x + r0.y);
  r0.y = 1 + -r0.y;
  r0.z = r0.x * r0.x;
  r1.x = -GeneralParams0.y + r0.w;
  r1.x = cmp(r1.x >= 0);
  r1.x = r1.x ? 1.000000 : 0;
  r0.z = r1.x / r0.z;
  r0.y = r0.y * r0.z;
  r0.z = -refMipBlurParams.y + r0.w;
  r0.w = -500 + r0.w;
  r0.w = saturate(0.000500000024 * r0.w);
  r0.w = r0.w * 15 + 1;
  r0.z = saturate(r0.z / refMipBlurParams.z);
  r0.z = r0.y * r0.z;
  r1.x = cmp(0 != refMipBlurParams.x);
  r0.y = r1.x ? r0.z : r0.y;
  r0.z = GeneralParams0.w * v1.w;
  r1.xyz = v1.xyz * r0.zzz;
  r1.xyz = r1.xyz * r0.yyy;
  r0.y = cmp(0 < r0.y);
  r0.y = r0.y ? 1.000000 : 0;
  o1.xyz = r1.xyz * r0.www;
  r0.zw = float2(-0.5,-0.5) + v2.xy;
  r0.zw = GeneralParams0.xx * r0.zw;
  r1.xyz = gViewInverse._m10_m11_m12 * r0.www;
  r1.xyz = r0.zzz * gViewInverse._m00_m01_m02 + r1.xyz;
  r0.xzw = r1.xyz * r0.xxx;
  r0.xyz = r0.xzw * r0.yyy + v0.xyz;
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o2.xyzw = r0.xyzw;
  o3.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o3.yzw = float3(0,0,0);
  return;
}