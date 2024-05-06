// ---- FNV Hash f38ba912a063657a

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

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = deferredLightParams[2].zxy * deferredLightParams[1].yzx;
  r0.xyz = deferredLightParams[2].yzx * deferredLightParams[1].zxy + -r0.xyz;
  r0.w = dot(v0.xy, v0.xy);
  r0.w = rsqrt(r0.w);
  r1.xy = v0.xy * r0.ww;
  r0.w = cmp(0.999899983 >= abs(v0.z));
  r1.xy = r0.ww ? r1.xy : 0;
  r0.xyz = r1.yyy * r0.xyz;
  r0.xyz = deferredLightParams[2].xyz * r1.xxx + r0.xyz;
  r0.w = 1 + -deferredLightParams[5].x;
  r1.xyzw = float4(1,-0,-0,-1) + v0.zxyz;
  r1.x = r1.x * r1.x;
  r1.yzw = cmp(abs(r1.yzw) < float3(9.99999975e-05,9.99999975e-05,9.99999975e-05));
  r0.w = -r1.x * r0.w + 1;
  r1.x = -r0.w * r0.w + 1;
  r2.xyz = deferredLightParams[1].xyz * r0.www;
  r0.w = min(1, abs(r1.x));
  r0.w = sqrt(r0.w);
  r3.xyz = r0.xyz * r0.www;
  r0.w = 1 + -v0.z;
  r4.xy = deferredLightParams[5].xy * r0.ww;
  r0.xyz = r4.yyy * r0.xyz;
  r4.xyz = deferredLightParams[1].xyz * r4.xxx;
  r0.w = cmp(0 >= v0.z);
  r0.xyz = r0.www ? r3.xyz : r0.xyz;
  r2.xyz = r0.www ? r2.xyz : r4.xyz;
  r0.xyz = r2.xyz + r0.xyz;
  r0.xyz = r0.xyz * deferredLightParams[4].yyy + deferredLightParams[0].xyz;
  r2.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.yyyy;
  r2.xyzw = r0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r2.xyzw;
  r2.xyzw = r0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  r2.xyzw = gWorldViewProj._m30_m31_m32_m33 + r2.xyzw;
  o0.xyzw = r2.xyzw;
  o1.xyz = r0.xyz;
  r0.xyz = -gViewInverse._m30_m31_m32 + r0.xyz;
  r3.x = r2.x + r2.w;
  r3.y = r2.w + -r2.y;
  o2.w = r2.w;
  o2.xy = float2(0.5,0.5) * r3.xy;
  r0.w = r1.z ? r1.y : 0;
  r0.w = r1.w ? r0.w : 0;
  r1.x = dot(r0.xyz, deferredLightParams[1].xyz);
  r1.yzw = -deferredLightParams[0].xyz + gViewInverse._m30_m31_m32;
  r2.x = dot(r1.yzw, r0.xyz);
  r2.y = deferredLightParams[5].x * deferredLightParams[5].x;
  r2.z = r2.y * r2.x;
  r2.w = dot(r1.yzw, deferredLightParams[1].xyz);
  r2.z = r1.x * r2.w + -r2.z;
  r3.x = dot(r0.xyz, r0.xyz);
  r3.y = r3.x * r2.y;
  r1.x = r1.x * r1.x + -r3.y;
  r3.y = dot(r1.yzw, r1.yzw);
  r2.y = r3.y * r2.y;
  r3.y = -deferredLightParams[4].y * deferredLightParams[4].y + r3.y;
  r3.y = r3.y * r3.x;
  r3.y = r2.x * r2.x + -r3.y;
  r3.y = sqrt(abs(r3.y));
  r3.y = -r3.y + -r2.x;
  r2.x = min(0, r2.x);
  r2.x = r2.x / r3.x;
  r1.yzw = -r0.xyz * r2.xxx + r1.yzw;
  r1.y = dot(r1.yzw, r1.yzw);
  r1.z = r3.y / r3.x;
  r1.w = sqrt(r3.x);
  r2.x = r2.w * r2.w + -r2.y;
  r2.y = cmp(r2.w < 0);
  r2.w = r2.x * r1.x;
  r2.x = cmp(r2.x < 0);
  r2.x = (int)r2.y | (int)r2.x;
  r2.y = r2.z * r2.z + -r2.w;
  r2.y = sqrt(abs(r2.y));
  r2.y = r2.z + -r2.y;
  r1.x = r2.y / -r1.x;
  r0.w = r0.w ? 0.99000001 : r1.x;
  r0.w = r2.x ? r0.w : 0;
  r2.x = saturate(max(r1.z, r0.w));
  r0.w = cmp(0 < r1.w);
  r1.xzw = r0.xyz / r1.www;
  r1.xzw = r0.www ? r1.xzw : 0;
  r2.y = 1;
  r2.xy = r0.ww ? r2.xy : 0;
  r3.xyz = r0.xyz * r2.xxx + gViewInverse._m30_m31_m32;
  r0.xyz = r0.xyz * r2.yyy + gViewInverse._m30_m31_m32;
  o3.xy = r2.xy;
  r2.xyz = r0.xyz + -r3.xyz;
  r2.x = dot(r2.xyz, r2.xyz);
  r2.x = sqrt(r2.x);
  r2.y = 0.00499999989 * r2.x;
  r2.x = max(1, r2.x);
  r3.xyz = r1.xzw * r2.yyy + r3.xyz;
  r4.xyz = -r1.xzw * r2.yyy + r0.xyz;
  r0.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.y = -globalFogParams[0].x + r0.x;
  r0.y = max(0, r0.y);
  r0.x = r0.y / r0.x;
  r0.x = r0.z * r0.x;
  r0.z = globalFogParams[2].z * r0.x;
  r0.x = cmp(0.00999999978 < abs(r0.x));
  r1.x = -1.44269502 * r0.z;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.z = r1.x / r0.z;
  r0.x = r0.x ? r0.z : 1;
  r0.z = globalFogParams[1].w * r0.y;
  r0.y = -globalFogParams[2].x + r0.y;
  r0.y = max(0, r0.y);
  r0.y = globalFogParams[1].x * r0.y;
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.x = r0.z * r0.x;
  r0.x = min(1, r0.x);
  r0.x = 1.44269502 * r0.x;
  r0.x = exp2(r0.x);
  r0.x = min(1, r0.x);
  r0.xy = float2(1,1) + -r0.xy;
  r0.z = -r0.x * globalFogParams[2].y + 1;
  r0.x = globalFogParams[2].y * r0.x;
  r0.z = globalFogParams[1].y * r0.z;
  r0.x = saturate(r0.z * r0.y + r0.x);
  r0.x = 1 + -r0.x;
  r0.y = deferredLightVolumeParams[0].x * deferredLightParams[3].w;
  r0.y = r0.y * r2.x;
  o2.z = r0.y * r0.x;
  r4.w = 1;
  r2.xyz = gViewInverse._m20_m21_m22;
  r2.w = gWorldView._m32;
  r0.x = dot(r4.xyzw, r2.xyzw);
  r0.y = deferredProjectionParams.z / deferredProjectionParams.w;
  o3.z = -r0.x + -r0.y;
  r0.x = deferredLightParams[4].y * deferredLightParams[4].y;
  r0.x = r1.y / r0.x;
  r0.x = 1 + -r0.x;
  r0.x = r0.x * r0.x;
  r0.y = 1 + -deferredLightVolumeParams[1].w;
  r0.y = r0.y * r0.x + deferredLightVolumeParams[1].w;
  r0.x = r0.x / r0.y;
  r1.xyz = -deferredLightVolumeParams[1].xyz + deferredLightParams[3].xyz;
  r0.xyz = r0.xxx * r1.xyz + deferredLightVolumeParams[1].xyz;
  o4.xyz = r0.www ? r0.xyz : 0;
  return;
}