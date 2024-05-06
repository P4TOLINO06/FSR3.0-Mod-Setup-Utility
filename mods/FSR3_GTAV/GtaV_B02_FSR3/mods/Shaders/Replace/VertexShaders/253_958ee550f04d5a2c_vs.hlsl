// ---- FNV Hash 958ee550f04d5a2c

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



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float3 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = deferredLightParams[2].zxy * deferredLightParams[1].yzx;
  r0.xyz = deferredLightParams[2].yzx * deferredLightParams[1].zxy + -r0.xyz;
  r0.w = cmp(0.999899983 >= abs(v0.z));
  r1.x = dot(v0.xy, v0.xy);
  r1.x = rsqrt(r1.x);
  r1.xy = v0.xy * r1.xx;
  r1.xy = r0.ww ? r1.xy : 0;
  r0.xyz = r1.yyy * r0.xyz;
  r0.xyz = deferredLightParams[2].xyz * r1.xxx + r0.xyz;
  r0.w = cmp(0 >= v0.z);
  r1.x = 1 + v0.z;
  r1.x = r1.x * r1.x;
  r1.y = 1 + -deferredLightParams[5].x;
  r1.x = -r1.x * r1.y + 1;
  r1.y = -r1.x * r1.x + 1;
  r1.y = min(1, abs(r1.y));
  r1.y = sqrt(r1.y);
  r1.xzw = deferredLightParams[1].xyz * r1.xxx;
  r2.xyz = r1.yyy * r0.xyz;
  r1.y = 1 + -v0.z;
  r3.xy = deferredLightParams[5].xy * r1.yy;
  r3.xzw = deferredLightParams[1].xyz * r3.xxx;
  r0.xyz = r3.yyy * r0.xyz;
  r0.xyz = r0.www ? r2.xyz : r0.xyz;
  r1.xyz = r0.www ? r1.xzw : r3.xzw;
  r0.xyz = r1.xyz + r0.xyz;
  r0.xyz = r0.xyz * deferredLightParams[4].yyy + deferredLightParams[0].xyz;
  r1.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r2.y = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r2.y);
  r1.w = cmp(0 < r0.w);
  if (r1.w != 0) {
    r3.xyz = -deferredLightParams[0].xyz + gViewInverse._m30_m31_m32;
    r1.w = deferredLightParams[5].x * deferredLightParams[5].x;
    r2.z = dot(r3.xyz, r1.xyz);
    r2.w = dot(r3.xyz, r3.xyz);
    r3.w = dot(r3.xyz, deferredLightParams[1].xyz);
    r4.x = dot(r1.xyz, deferredLightParams[1].xyz);
    r4.y = r4.x * r4.x;
    r4.z = -r1.w * r2.y + r4.y;
    r4.w = r2.z * r1.w;
    r5.xy = r4.xx * r3.ww + -r4.ww;
    r4.w = r2.w * r1.w;
    r3.w = r3.w * r3.w + -r4.w;
    r3.w = r4.z * r3.w;
    r3.w = r5.y * r5.y + -r3.w;
    r2.x = -r4.z;
    r6.x = sqrt(abs(r3.w));
    r3.w = deferredLightParams[4].y * deferredLightParams[4].y;
    r2.w = -deferredLightParams[4].y * deferredLightParams[4].y + r2.w;
    r2.w = r2.w * r2.y;
    r2.w = r2.z * r2.z + -r2.w;
    r2.w = sqrt(abs(r2.w));
    r5.zw = -r2.zz;
    r6.y = -r6.x;
    r6.zw = float2(1,-1) * r2.ww;
    r5.xyzw = r6.xyzw + r5.xyzw;
    r5.xyzw = r5.xyzw / r2.xxyy;
    r2.x = max(r5.z, r5.w);
    r6.xyz = r1.xyz * r5.xxx + gViewInverse._m30_m31_m32;
    r7.xyz = r1.xyz * r5.yyy + gViewInverse._m30_m31_m32;
    r6.xyz = -deferredLightParams[0].xyz + r6.xyz;
    r6.x = dot(r6.xyz, deferredLightParams[1].xyz);
    r7.xyz = -deferredLightParams[0].xyz + r7.xyz;
    r6.y = dot(r7.xyz, deferredLightParams[1].xyz);
    r4.zw = cmp(r6.xy >= float2(0,0));
    r4.zw = r4.zw ? float2(1,1) : 0;
    r4.zw = r5.xy * r4.zw;
    r2.w = max(r4.z, r4.w);
    r4.y = r4.y / r2.y;
    r1.w = cmp(r4.y >= r1.w);
    r4.x = cmp(0 < r4.x);
    r1.w = r1.w ? r4.x : 0;
    r1.w = r1.w ? 1000000.000000 : 0;
    r1.w = r2.w + r1.w;
    r1.w = min(r1.w, r2.x);
    r4.y = max(1.00999999, r1.w);
    r1.w = min(0, r2.z);
    r1.w = r1.w / r2.y;
    r2.xyz = -r1.xyz * r1.www + r3.xyz;
    r1.w = dot(r2.xyz, r2.xyz);
    r1.w = r1.w / r3.w;
    r1.w = 1 + -r1.w;
    r1.w = r1.w * r1.w;
    r2.x = 1 + -deferredLightVolumeParams[1].w;
    r2.x = r2.x * r1.w + deferredLightVolumeParams[1].w;
    r1.w = r1.w / r2.x;
    r2.xyz = -deferredLightVolumeParams[1].xyz + deferredLightParams[3].xyz;
    o4.xyz = r1.www * r2.xyz + deferredLightVolumeParams[1].xyz;
    r2.xyz = r1.xyz / r0.www;
    r4.x = 1;
  } else {
    o4.xyz = float3(0,0,0);
    r2.xyz = float3(0,0,0);
    r4.xy = float2(0,0);
  }
  r3.xyz = r1.xyz * r4.xxx + gViewInverse._m30_m31_m32;
  r1.xyz = r1.xyz * r4.yyy + gViewInverse._m30_m31_m32;
  r1.xyz = r1.xyz + -r3.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r1.x = 0.00499999989 * r0.w;
  r1.xyz = r2.xyz * r1.xxx + r3.xyz;
  r1.w = deferredLightVolumeParams[0].x * deferredLightParams[3].w;
  r0.w = max(1, r0.w);
  r0.w = r1.w * r0.w;
  r1.xyz = -gViewInverse._m30_m31_m32 + r1.xyz;
  r1.x = dot(r1.xyz, r1.xyz);
  r1.x = sqrt(r1.x);
  r1.y = -globalFogParams[0].x + r1.x;
  r1.y = max(0, r1.y);
  r1.x = r1.y / r1.x;
  r1.x = r1.z * r1.x;
  r1.z = globalFogParams[2].z * r1.x;
  r1.x = cmp(0.00999999978 < abs(r1.x));
  r1.w = -1.44269502 * r1.z;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r1.z = r1.w / r1.z;
  r1.x = r1.x ? r1.z : 1;
  r1.z = globalFogParams[1].w * r1.y;
  r1.x = r1.z * r1.x;
  r1.x = min(1, r1.x);
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = min(1, r1.x);
  r1.x = 1 + -r1.x;
  r1.z = globalFogParams[2].y * r1.x;
  r1.x = -r1.x * globalFogParams[2].y + 1;
  r1.y = -globalFogParams[2].x + r1.y;
  r1.y = max(0, r1.y);
  r1.xy = globalFogParams[1].yx * r1.xy;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r1.x = saturate(r1.x * r1.y + r1.z);
  r1.x = 1 + -r1.x;
  o2.z = r1.x * r0.w;
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r1.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  r1.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r2.x = r1.x + r1.w;
  r2.y = r1.w + -r1.y;
  o2.xy = float2(0.5,0.5) * r2.xy;
  o0.xyzw = r1.xyzw;
  o2.w = r1.w;
  o1.xyz = r0.xyz;
  r4.z = 0;
  o3.xyz = r4.xyz;
  return;
}