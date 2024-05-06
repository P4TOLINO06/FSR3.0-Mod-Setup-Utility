// ---- FNV Hash e8070f9e60230e65

// ---- Created with 3Dmigoto v1.3.16 on Fri Mar  8 21:28:29 2024

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer clouds_locals : register(b12)
{
  float3 gSkyColor : packoffset(c0);
  float3 gEastMinusWestColor : packoffset(c1);
  float3 gWestColor : packoffset(c2);
  float3 gSunDirection : packoffset(c3);
  float3 gSunColor : packoffset(c4);
  float3 gCloudColor : packoffset(c5);
  float3 gAmbientColor : packoffset(c6);
  float3 gBounceColor : packoffset(c7);
  float4 gDensityShiftScale : packoffset(c8);
  float4 gScatterG_GSquared_PhaseMult_Scale : packoffset(c9);
  float4 gPiercingLightPower_Strength_NormalStrength_Thickness : packoffset(c10);
  float3 gScaleDiffuseFillAmbient : packoffset(c11);
  float3 gWrapLighting_MSAARef : packoffset(c12);
  float4 gNearFarQMult : packoffset(c13);
  float3 gAnimCombine : packoffset(c14);
  float3 gAnimSculpt : packoffset(c15);
  float3 gAnimBlendWeights : packoffset(c16);
  float4 gUVOffset[2] : packoffset(c17);
  row_major float4x4 gCloudViewProj : packoffset(c19);
  float4 gCameraPos : packoffset(c23);
  float2 gUVOffset1 : packoffset(c24);
  float2 gUVOffset2 : packoffset(c24.z);
  float2 gUVOffset3 : packoffset(c25);
  float2 gRescaleUV1 : packoffset(c25.z);
  float2 gRescaleUV2 : packoffset(c26);
  float2 gRescaleUV3 : packoffset(c26.z);
  float gSoftParticleRange : packoffset(c27);
  float gEnvMapAlphaScale : packoffset(c27.y);
  float2 cloudLayerAnimScale1 : packoffset(c27.z);
  float2 cloudLayerAnimScale2 : packoffset(c28);
  float2 cloudLayerAnimScale3 : packoffset(c28.z);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : POSITION0,
  float4 v1 : COLOR0,
  float3 v2 : NORMAL0,
  float2 v3 : TEXCOORD0,
  float4 v4 : TANGENT0,
  out float4 o0 : SV_Position0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(0 != gCameraPos.w);
  r0.yzw = gWorld._m10_m11_m12 * v0.yyy;
  r0.yzw = v0.xxx * gWorld._m00_m01_m02 + r0.yzw;
  r0.yzw = v0.zzz * gWorld._m20_m21_m22 + r0.yzw;
  r0.yzw = v0.www * gWorld._m30_m31_m32 + r0.yzw;
  r1.xyzw = gCloudViewProj._m10_m11_m12_m13 * r0.zzzz;
  r1.xyzw = r0.yyyy * gCloudViewProj._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = r0.wwww * gCloudViewProj._m20_m21_m22_m23 + r1.xyzw;
  r1.xyzw = gCloudViewProj._m30_m31_m32_m33 + r1.xyzw;
  r0.y = cmp(r1.z < 0);
  r0.z = 0.100000001 / r1.w;
  r0.y = r0.y ? r0.z : r1.z;
  r0.z = cmp(r1.w < r1.z);
  r0.w = -0.100000001 + r1.w;
  r0.z = r0.z ? r0.w : r1.z;
  r0.x = r0.x ? r0.y : r0.z;
  r0.y = cmp(0 < r1.w);
  o0.z = r0.y ? r0.x : r1.z;
  o0.xyw = r1.xyw;
  o1.xyzw = v1.xyzw;
  r0.xy = v3.xy * gRescaleUV1.xy + gUVOffset1.xy;
  o2.xy = gUVOffset[0].xy * cloudLayerAnimScale1.xy + r0.xy;
  r0.xy = v3.xy * gRescaleUV2.xy + gUVOffset2.xy;
  o3.xy = gUVOffset[0].zw * cloudLayerAnimScale2.xy + r0.xy;
  r0.xy = v3.xy * gRescaleUV3.xy + gUVOffset3.xy;
  o3.zw = gUVOffset[1].xy * cloudLayerAnimScale3.xy + r0.xy;
  return;
}