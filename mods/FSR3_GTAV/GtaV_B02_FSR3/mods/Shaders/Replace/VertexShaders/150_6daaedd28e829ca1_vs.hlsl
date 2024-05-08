// ---- FNV Hash 6daaedd28e829ca1

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

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
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

cbuffer megashader_locals : register(b12)
{
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float3 specMapIntMask : packoffset(c1);
  float useTessellation : packoffset(c1.w);
  float HardAlphaBlend : packoffset(c2);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  float3 v3 : NORMAL0,
  float4 v4 : TANGENT0,
  out float4 o0 : COLOR0,
  out float4 o1 : COLOR1,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD2,
  out float4 o5 : TEXCOORD3,
  out float4 o6 : TEXCOORD4,
  out float4 o7 : TEXCOORD5,
  out float4 o8 : TEXCOORD6,
  out float4 o9 : TEXCOORD7,
  out float4 o10 : TEXCOORD8,
  out float3 o11 : TEXCOORD9,
  out float4 o12 : SV_Position0,
  out float4 o13 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.w
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyzw = float4(0,0,0,0);
  o1.xyzw = float4(0,0,0,0);
  o2.xy = v2.xy;
  o2.zw = float2(0,0);
  r0.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r0.xyz = v0.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v0.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.xyz = gWorld._m30_m31_m32 + r0.xyz;
  o3.xyz = r0.xyz;
  r0.xyz = gViewInverse._m30_m31_m32 + -r0.xyz;
  r1.xyz = gWorld._m10_m11_m12 * v3.yyy;
  r1.xyz = v3.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v3.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r1.xyz * r0.www;
  r0.w = dot(r1.xyz, r0.xyz);
  r1.w = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.w = (int)r0.w + (int)-r1.w;
  r0.w = (int)r0.w;
  r1.xyz = r1.xyz * r0.www;
  o4.xyz = r1.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r0.xyz * r0.www + -gDirectionalLight.xyz;
  r0.xyz = r0.xyz * r0.www;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r3.y = saturate(dot(r2.xyz, -gDirectionalLight.xyz));
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyw = r1.xyz * r0.www;
  r0.w = r1.z * r0.w + gLightNaturalAmbient0.w;
  r0.w = gLightNaturalAmbient1.w * r0.w;
  r0.w = max(0, r0.w);
  r3.x = saturate(dot(r0.xyz, r1.xyw));
  r0.xy = float2(1,1) + -r3.xy;
  r3.xy = r0.xy * r0.xy;
  r3.xy = r3.xy * r3.xy;
  r0.xy = r3.xy * r0.xy;
  r0.z = 1 + -specularFresnel;
  r0.xy = specularFresnel * r0.xy + r0.zz;
  r0.z = -1 + r0.x;
  r0.x = max(v1.w, r0.x);
  r0.z = r0.x * r0.z + 1;
  o10.w = r0.x;
  r0.x = saturate(specularIntensityMult);
  r0.z = -r0.x * r0.z + 1;
  r1.z = dot(r1.xyw, -gDirectionalLight.xyz);
  r2.w = saturate(r1.z);
  r2.w = r2.w + -abs(r1.z);
  r1.z = v1.w * r2.w + abs(r1.z);
  r2.w = r1.z * r0.z;
  o5.xyz = gDirectionalColour.xyz * r2.www;
  o5.w = 1 + -r0.z;
  r2.x = dot(r1.xyw, r2.xyz);
  r2.x = saturate(9.99999994e-09 + r2.x);
  r2.x = log2(r2.x);
  r2.y = -500 + specularFalloffMult;
  r2.y = max(0, r2.y);
  r2.z = specularFalloffMult + -r2.y;
  r2.y = 558 * r2.y;
  r2.y = r2.z * 3 + r2.y;
  r2.zw = float2(2,9.99999994e-09) + r2.yy;
  o6.w = r2.y;
  r2.x = r2.w * r2.x;
  r2.y = 0.125 * r2.z;
  r2.x = exp2(r2.x);
  r0.y = r2.x * r0.y;
  r0.y = r0.y * r2.y;
  r0.x = r0.y * r0.x;
  r0.x = r0.x * r1.z;
  o6.xyz = gDirectionalColour.xyz * r0.xxx;
  o7.xyz = float3(0,0,0);
  r0.x = globalScalars.z * globalScalars.z;
  o7.w = r0.x;
  r0.y = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r0.y = globalScalars.y * r0.y;
  r0.y = r0.y * r0.y;
  o8.w = r0.y;
  o8.xyz = float3(0,0,0);
  o9.xyz = float3(0,0,0);
  o9.w = v1.w;
  o10.xyz = float3(0,0,0);
  r2.xyz = gLightArtificialIntAmbient0.xyz * r0.www + gLightArtificialIntAmbient1.xyz;
  r2.xyz = globalScalars2.zzz * r2.xyz;
  r3.xyz = gLightArtificialExtAmbient0.xyz * r0.www + gLightArtificialExtAmbient1.xyz;
  r4.xyz = gLightNaturalAmbient0.xyz * r0.www + gLightNaturalAmbient1.xyz;
  r0.w = 1 + -globalScalars2.z;
  r2.xyz = r3.xyz * r0.www + r2.xyz;
  r2.xyz = r2.xyz * r0.yyy;
  r3.x = gLightArtificialIntAmbient1.w;
  r3.y = gLightArtificialExtAmbient0.w;
  r3.z = gLightArtificialExtAmbient1.w;
  r0.y = saturate(dot(r3.xyz, r1.xyw));
  r1.xyz = gDirectionalAmbientColour.xyz * r0.yyy + r4.xyz;
  r0.xyw = r1.xyz * r0.xxx + r2.xyz;
  o11.xyz = r0.xyw * r0.zzz;
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o12.xyzw = r0.xyzw;
  o13.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o13.yzw = float3(0,0,0);
  return;
}