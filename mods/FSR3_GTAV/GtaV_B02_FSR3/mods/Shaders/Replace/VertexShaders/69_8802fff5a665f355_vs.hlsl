// ---- FNV Hash 8802fff5a665f355

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
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

cbuffer terrain_cb_common_locals : register(b12)
{
  float specularFalloffMult : packoffset(c0);
  float specularFalloffMultSpecMap : packoffset(c0.y);
  float specFalloffAdjust : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float specularIntensityMultSpecMap : packoffset(c1);
  float specIntensityAdjust : packoffset(c1.y);
  float bumpiness : packoffset(c1.z);
  float parallaxSelfShadowAmount : packoffset(c1.w);
  float heightScale0 : packoffset(c2);
  float heightBias0 : packoffset(c2.y);
  float heightScale1 : packoffset(c2.z);
  float heightBias1 : packoffset(c2.w);
  float heightScale2 : packoffset(c3);
  float heightBias2 : packoffset(c3.y);
  float heightScale3 : packoffset(c3.z);
  float heightBias3 : packoffset(c3.w);
  float bumpSelfShadowAmount : packoffset(c4);
  float4 materialWetnessMultiplier : packoffset(c5);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : COLOR1,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
  out float4 o0 : SV_Position0,
  out float3 o1 : TEXCOORD0,
  out float4 o2 : COLOR0,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float4 o6 : TEXCOORD5,
  out float3 o7 : TEXCOORD6,
  out float2 o8 : BLENDWEIGHT0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r0.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.xyz = gViewInverse._m11_m12_m10 * gViewInverse._m02_m00_m01;
  r0.xyz = gViewInverse._m01_m02_m00 * gViewInverse._m12_m10_m11 + -r0.xyz;
  r0.xyz = -r0.xyz * float3(8,8,8) + gViewInverse._m30_m31_m32;
  r1.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r1.xyz = v0.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v0.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  r0.xyz = -r1.xyz + r0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  o1.z = sqrt(r0.x);
  o1.xy = v3.xy;
  o2.xyzw = v2.xyzw;
  r0.xyz = gWorld._m10_m11_m12 * v5.yyy;
  r0.xyz = v5.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v5.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.w = saturate(dot(r0.xyz, -gDirectionalLight.xyz));
  r0.w = -bumpSelfShadowAmount + r0.w;
  o3.w = 9 * r0.w;
  o3.xyz = r0.xyz;
  r2.xyz = -gViewInverse._m30_m31_m32 + r1.xyz;
  o7.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = 3.99999999e-06 * r0.w;
  r1.x = min(1, r0.w);
  r1.y = 1 + -r1.x;
  r1.xy = saturate(-globalScalars2.zz + r1.xy);
  r0.w = -1 + gDirectionalAmbientColour.w;
  r1.xy = r1.xy * r0.ww + float2(1,1);
  o4.xy = saturate(v1.xy * r1.xy);
  o4.z = v1.z;
  o4.w = 0;
  r1.xyz = gWorld._m10_m11_m12 * v6.yyy;
  r1.xyz = v6.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v6.zzz * gWorld._m20_m21_m22 + r1.xyz;
  o5.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o6.xyz = v6.www * r0.xyz;
  o8.xy = v4.xy;
  return;
}