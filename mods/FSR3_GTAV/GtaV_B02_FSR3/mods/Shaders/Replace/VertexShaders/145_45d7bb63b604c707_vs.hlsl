// ---- FNV Hash 45d7bb63b604c707

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

cbuffer cable_locals : register(b11)
{
  float shader_radiusScale : packoffset(c0);
  float shader_fadeExponent : packoffset(c0.y);
  float shader_windAmount : packoffset(c0.z);
  float3 shader_cableDiffuse : packoffset(c1);
  float3 shader_cableDiffuse2 : packoffset(c2);
  float2 shader_cableAmbient : packoffset(c3);
  float shader_cableEmissive : packoffset(c3.z);
  row_major float4x4 gViewProj : packoffset(c4);
  float4 gCableParams[5] : packoffset(c8);
  float alphaTestValue : packoffset(c13);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float3 v1 : NORMAL0,
  float4 v2 : COLOR0,
  float2 v3 : TEXCOORD0,
  out float4 o0 : CTRL_POS0,
  out float4 o1 : CTRL_COLOR0,
  out float4 o2 : CTRL_TEXCOORD0,
  out float3 o3 : CTRL_TEXCOORD1,
  out float3 o4 : CTRL_TEXCOORD2,
  out float2 o5 : CTRL_PIXEL_OFFSET0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = gCableParams[1].xy + v2.xy;
  r0.xy = float2(6.28318501,6.28318501) * r0.xy;
  r0.xy = sin(r0.xy);
  r0.zw = gCableParams[1].zw * shader_windAmount;
  r0.xy = r0.xy * r0.zw;
  r0.xy = sin(r0.xy);
  r0.z = dot(r0.xy, r0.xy);
  r1.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r1.xyz = v0.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = v0.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  r2.z = v3.y * r0.z + r1.z;
  r2.xy = v3.yy * r0.xy + r1.xy;
  r0.xyz = -gViewInverse._m30_m31_m32 + r2.xyz;
  r0.x = dot(r0.xyz, -gViewInverse._m20_m21_m22);
  r0.x = max(0.00999999978, r0.x);
  r0.x = gCableParams[0].x / r0.x;
  r0.y = max(9.99999994e-09, r0.x);
  r0.zw = gCableParams[0].yz * shader_radiusScale;
  r0.z = abs(v3.x) * r0.z;
  r0.w = max(9.99999994e-09, r0.w);
  r0.x = r0.z * r0.x;
  r0.z = saturate(r0.x);
  r0.z = r0.z * 0.5 + r0.x;
  r0.x = min(1, r0.x);
  r0.x = r0.x * r0.x;
  r0.x = log2(r0.x);
  r0.x = r0.w * r0.x;
  r0.x = exp2(r0.x);
  r0.y = r0.z / r0.y;
  r0.w = cmp(0 < v3.x);
  r1.x = r0.w ? 1 : -1;
  o2.w = r0.w ? 1.000000 : 0;
  r0.y = r1.x * r0.y;
  o5.x = r1.x * r0.z;
  o5.y = r0.z;
  r1.xyz = gViewInverse._m32_m30_m31 + -r2.zxy;
  r3.xyz = gWorld._m11_m12_m10 * v1.yyy;
  r3.xyz = v1.xxx * gWorld._m01_m02_m00 + r3.xyz;
  r3.xyz = v1.zzz * gWorld._m21_m22_m20 + r3.xyz;
  r4.xyz = r3.xyz * r1.xyz;
  r1.xyz = r1.zxy * r3.yzx + -r4.xyz;
  r0.z = dot(r1.xyz, r1.xyz);
  r0.z = rsqrt(r0.z);
  r1.xyz = r1.xyz * r0.zzz;
  r0.yzw = r0.yyy * r1.xyz + r2.xyz;
  o0.xyz = r0.yzw;
  r0.yzw = -gViewInverse._m30_m31_m32 + r0.yzw;
  o0.w = shader_cableEmissive;
  r0.y = dot(r0.yzw, r0.yzw);
  r0.y = sqrt(r0.y);
  r0.z = -globalFogParams[0].x + r0.y;
  r0.z = max(0, r0.z);
  r0.y = r0.z / r0.y;
  r0.y = r0.w * r0.y;
  r0.w = globalFogParams[2].z * r0.y;
  r0.y = cmp(0.00999999978 < abs(r0.y));
  r1.w = -1.44269502 * r0.w;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r0.w = r1.w / r0.w;
  r0.y = r0.y ? r0.w : 1;
  r0.w = globalFogParams[1].w * r0.z;
  r0.z = -globalFogParams[2].x + r0.z;
  r0.z = max(0, r0.z);
  r0.z = globalFogParams[1].x * r0.z;
  r0.z = 1.44269502 * r0.z;
  r0.z = exp2(r0.z);
  r0.y = r0.w * r0.y;
  r0.y = min(1, r0.y);
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = min(1, r0.y);
  r0.yz = float2(1,1) + -r0.yz;
  r0.w = -r0.y * globalFogParams[2].y + 1;
  r0.y = globalFogParams[2].y * r0.y;
  r0.w = globalFogParams[1].y * r0.w;
  r0.y = saturate(r0.w * r0.z + r0.y);
  r0.y = 1 + -r0.y;
  r0.x = r0.x * r0.y;
  o1.w = gCableParams[0].w * r0.x;
  r0.xyz = shader_cableDiffuse2.xyz + -shader_cableDiffuse.xyz;
  o1.xyz = v2.www * r0.xyz + shader_cableDiffuse.xyz;
  o2.xy = shader_cableAmbient.xy;
  o2.z = v2.x;
  o3.xyz = r1.xyz;
  r0.xyz = r1.zxy * r3.xyz;
  o4.xyz = r1.yzx * r3.yzx + -r0.xyz;
  return;
}