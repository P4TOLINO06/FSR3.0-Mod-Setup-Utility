// ---- FNV Hash eb15f3e328068731

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer ssao_locals : register(b12)
{
  float4 g_projParams : packoffset(c0);
  float4 gNormalOffset : packoffset(c1);
  float4 gOffsetScale0 : packoffset(c2);
  float4 gOffsetScale1 : packoffset(c3);
  float g_SSAOStrength : packoffset(c4);
  float4 g_CPQSMix_QSFadeIn : packoffset(c5);
  float4 TargetSizeParam : packoffset(c6);
  float4 FallOffAndKernelParam : packoffset(c7);
  float4 g_MSAAPointTexture1_Dim : packoffset(c8);
  float4 g_MSAAPointTexture2_Dim : packoffset(c9);
  float4 gExtraParams0 : packoffset(c10);
  float4 gExtraParams1 : packoffset(c11);
  float4 gExtraParams2 : packoffset(c12);
  float4 gExtraParams3 : packoffset(c13);
  float4 gExtraParams4 : packoffset(c14);
  float3 gPerspectiveShearParams0 : packoffset(c15);
  float3 gPerspectiveShearParams1 : packoffset(c16);
  float3 gPerspectiveShearParams2 : packoffset(c17);
  row_major float4x4 gPrevViewProj : packoffset(c18);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState GBufferTextureSamplerDepth_s : register(s10);
Texture2D<float> gbufferTextureDepth : register(t10);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = gbufferTextureDepth.Gather(GBufferTextureSamplerDepth_s, v1.xy).xyzw;
  r0.xy = min(r0.xy, r0.zw);
  r0.x = min(r0.x, r0.y);
  r0.y = 1 + g_projParams.w;
  r0.x = r0.y + -r0.x;
  o0.x = g_projParams.z / r0.x;
  return;
}