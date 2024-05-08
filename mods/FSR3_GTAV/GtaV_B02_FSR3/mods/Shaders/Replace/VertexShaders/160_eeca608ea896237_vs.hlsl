// ---- FNV Hash eeca608ea896237

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

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

cbuffer deferred_volume_locals : register(b10)
{
  float4 deferredVolumePosition : packoffset(c0);
  float4 deferredVolumeDirection : packoffset(c1);
  float4 deferredVolumeTangentXAndShaftRadius : packoffset(c2);
  float4 deferredVolumeTangentYAndShaftLength : packoffset(c3);
  float4 deferredVolumeColour : packoffset(c4);
  float4 deferredVolumeShaftPlanes[3] : packoffset(c5);
  float4 deferredVolumeShaftGradient : packoffset(c8);
  float4 deferredVolumeShaftGradientColourInv : packoffset(c9);
  row_major float4x4 deferredVolumeShaftCompositeMtx : packoffset(c10);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float3 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v0.xy;
  r0.xzw = deferredVolumeTangentXAndShaftRadius.xyz * r0.xxx + deferredVolumePosition.xyz;
  r0.xyz = deferredVolumeTangentYAndShaftLength.xyz * r0.yyy + r0.xzw;
  r1.xyz = deferredVolumeTangentYAndShaftLength.www * deferredVolumeDirection.xyz;
  r0.xyz = r1.xyz * v0.zzz + r0.xyz;
  r1.xyzw = deferredVolumeShaftCompositeMtx._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * deferredVolumeShaftCompositeMtx._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = r0.zzzz * deferredVolumeShaftCompositeMtx._m20_m21_m22_m23 + r1.xyzw;
  o0.xyzw = deferredVolumeShaftCompositeMtx._m30_m31_m32_m33 + r1.xyzw;
  o1.xyz = r0.xyz;
  r1.xyz = gWorldViewProj._m10_m11_m13 * r0.yyy;
  r1.xyz = r0.xxx * gWorldViewProj._m00_m01_m03 + r1.xyz;
  r1.xyz = r0.zzz * gWorldViewProj._m20_m21_m23 + r1.xyz;
  r0.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r1.xyz = gWorldViewProj._m30_m31_m33 + r1.xyz;
  r2.x = r1.x + r1.z;
  r2.y = r1.z + -r1.y;
  o2.w = r1.z;
  o2.xy = float2(0.5,0.5) * r2.xy;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = sqrt(r0.w);
  r1.x = -globalFogParams[0].x + r0.w;
  r1.x = max(0, r1.x);
  r0.w = r1.x / r0.w;
  r0.w = r0.z * r0.w;
  r1.y = globalFogParams[2].z * r0.w;
  r0.w = cmp(0.00999999978 < abs(r0.w));
  r1.z = -1.44269502 * r1.y;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.y = r1.z / r1.y;
  r0.w = r0.w ? r1.y : 1;
  r1.y = globalFogParams[1].w * r1.x;
  r1.x = -globalFogParams[2].x + r1.x;
  r1.x = max(0, r1.x);
  r1.x = globalFogParams[1].x * r1.x;
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.w = r1.y * r0.w;
  r0.w = min(1, r0.w);
  r0.w = 1.44269502 * r0.w;
  r0.w = exp2(r0.w);
  r0.w = min(1, r0.w);
  r0.w = 1 + -r0.w;
  r1.y = -r0.w * globalFogParams[2].y + 1;
  r0.w = globalFogParams[2].y * r0.w;
  r1.y = globalFogParams[1].y * r1.y;
  r0.w = saturate(r1.y * r1.x + r0.w);
  o2.z = 1 + -r0.w;
  r1.xyz = gViewInverse._m30_m31_m32;
  r1.w = 1;
  r0.w = dot(r1.xyzw, deferredVolumeShaftPlanes[0].xyzw);
  o3.x = -r0.w;
  r0.w = dot(r1.xyzw, deferredVolumeShaftPlanes[1].xyzw);
  r1.x = dot(r1.xyzw, deferredVolumeShaftPlanes[2].xyzw);
  o3.z = -r1.x;
  o3.y = -r0.w;
  o4.x = dot(r0.xyz, deferredVolumeShaftPlanes[0].xyz);
  o4.y = dot(r0.xyz, deferredVolumeShaftPlanes[1].xyz);
  o4.z = dot(r0.xyz, deferredVolumeShaftPlanes[2].xyz);
  return;
}