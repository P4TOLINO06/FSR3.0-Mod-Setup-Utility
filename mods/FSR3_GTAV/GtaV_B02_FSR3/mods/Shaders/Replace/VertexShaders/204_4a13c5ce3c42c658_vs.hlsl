// ---- FNV Hash 4a13c5ce3c42c658

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 21:02:16 2023

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

cbuffer lighting_locals : register(b12)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

cbuffer vfx_fogvolume_locals : register(b11)
{
  float3 fogVolumeColor : packoffset(c0);
  float3 fogVolumePosition : packoffset(c1);
  float4 fogVolumeParams : packoffset(c2);
  row_major float4x4 fogVolumeTransform : packoffset(c3);
  row_major float4x4 fogVolumeInvTransform : packoffset(c7);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float3 o4 : TEXCOORD4,
  out float4 o5 : SV_Position0,
  out float4 o6 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v0.xyz, v0.xyz);
  r0.y = cmp(r0.x != 0.000000);
  r0.x = rsqrt(r0.x);
  r0.xzw = v0.xyz * r0.xxx;
  r0.xyz = r0.yyy ? r0.xzw : v0.xyz;
  r0.xyz = r0.xyz * fogVolumeParams.zzz + fogVolumePosition.xyz;
  r1.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r2.xyz = -fogVolumePosition.xyz + gViewInverse._m30_m31_m32;
  r3.z = dot(r1.xyz, r1.xyz);
  r0.w = dot(r2.xyz, r1.xyz);
  r1.w = dot(r2.xyz, r2.xyz);
  r2.w = fogVolumeParams.z * fogVolumeParams.z;
  r1.w = -fogVolumeParams.z * fogVolumeParams.z + r1.w;
  r1.w = r3.z * r1.w;
  r1.w = r0.w * r0.w + -r1.w;
  r1.w = sqrt(abs(r1.w));
  r3.x = r1.w + -r0.w;
  r3.x = r3.x / r3.z;
  r1.w = -r1.w + -r0.w;
  r1.w = r1.w / r3.z;
  r3.y = max(r3.x, r1.w);
  r0.w = min(0, r0.w);
  r4.xyz = r1.xyz * r0.www;
  r4.xyz = r4.xyz / r3.zzz;
  r2.xyz = -r4.xyz + r2.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = r0.w / r2.w;
  r0.w = 1 + -r0.w;
  r0.w = r0.w * r0.w;
  r0.w = min(1, r0.w);
  r0.w = log2(r0.w);
  r0.w = fogVolumeParams.y * r0.w;
  o3.w = exp2(r0.w);
  pos.xyzw = float4(r0.xyz, 1);
  r2.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r2.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r2.xyzw;
  r0.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r0.z = max(0, r0.z);
  r2.x = r0.x + r0.w;
  r2.y = r0.w + -r0.y;
  r2.xy = float2(0.5,0.5) * r2.xy;
  r2.zw = r2.xy / r0.ww;
  r4.xy = r2.zw * float2(2,-2) + float2(-1,1);
  r4.z = 1;
  o3.x = dot(r4.xyz, deferredPerspectiveShearParams0.xyz);
  o3.y = dot(r4.xyz, deferredPerspectiveShearParams1.xyz);
  o3.z = dot(r4.xyz, deferredPerspectiveShearParams2.xyz);
  r4.xyz = r3.yyy * r1.xyz;
  r1.w = cmp(9.99999975e-06 < r3.z);
  if (r1.w != 0) {
    r1.w = sqrt(r3.z);
    r2.z = -globalFogParams[0].x + r1.w;
    r2.z = max(0, r2.z);
    r1.w = r2.z / r1.w;
    r1.w = r1.z * r1.w;
    r2.w = globalFogParams[2].z * r1.w;
    r1.w = cmp(0.00999999978 < abs(r1.w));
    r3.x = -1.44269502 * r2.w;
    r3.x = exp2(r3.x);
    r3.x = 1 + -r3.x;
    r2.w = r3.x / r2.w;
    r1.w = r1.w ? r2.w : 1;
    r2.w = globalFogParams[1].w * r2.z;
    r1.w = r2.w * r1.w;
    r1.w = min(1, r1.w);
    r1.w = 1.44269502 * r1.w;
    r1.w = exp2(r1.w);
    r1.w = min(1, r1.w);
    r1.w = 1 + -r1.w;
    r2.w = globalFogParams[2].y * r1.w;
    r3.x = rsqrt(r3.z);
    r5.xyz = r3.xxx * r1.xyz;
    r3.x = saturate(dot(r5.xyz, globalFogParams[4].xyz));
    r3.x = log2(r3.x);
    r3.x = globalFogParams[4].w * r3.x;
    r3.x = exp2(r3.x);
    r3.w = saturate(dot(r5.xyz, globalFogParams[3].xyz));
    r3.w = log2(r3.w);
    r3.w = globalFogParams[3].w * r3.w;
    r3.w = exp2(r3.w);
    r1.w = -r1.w * globalFogParams[2].y + 1;
    r1.w = globalFogParams[1].y * r1.w;
    r4.w = -globalFogParams[2].x + r2.z;
    r4.w = max(0, r4.w);
    r4.w = globalFogParams[1].x * r4.w;
    r4.w = 1.44269502 * r4.w;
    r4.w = exp2(r4.w);
    r4.w = 1 + -r4.w;
    r2.w = saturate(r1.w * r4.w + r2.w);
    r2.z = -globalFogParams[1].z * r2.z;
    r2.z = 1.44269502 * r2.z;
    r2.z = exp2(r2.z);
    r2.z = 1 + -r2.z;
    r5.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r5.xyz = r3.xxx * r5.xyz + globalFogColorE.xyz;
    r6.xyz = globalFogColor.xyz + -r5.xyz;
    r5.xyz = r3.www * r6.xyz + r5.xyz;
    r5.xyz = -globalFogColorN.xyz + r5.xyz;
    r5.xyz = r2.zzz * r5.xyz + globalFogColorN.xyz;
    r6.x = globalFogColor.w + -r5.x;
    r6.y = globalFogColorE.w + -r5.y;
    r6.z = globalFogColorN.w + -r5.z;
    r5.xyz = r1.www * r6.xyz + r5.xyz;
    r1.w = saturate(fogVolumeParams.w * r2.w);
    r5.xyz = -fogVolumeColor.xyz + r5.xyz;
    o4.xyz = r1.www * r5.xyz + fogVolumeColor.xyz;
  } else {
    o4.xyz = fogVolumeColor.xyz;
  }
  o2.w = dot(r4.xyz, r4.xyz);
  o6.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o2.x = 1;
  o2.yz = r3.yz;
  o5.xyzw = r0.xyzw;
  o6.yzw = float3(0,0,0);
  o0.xyz = r1.xyz;
  o1.z = r0.w;
  o1.xy = r2.xy;
  return;
}