// ---- FNV Hash 449e7b70aff7352a

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer postfx_cbuffer_adaptiveDOF : register(b7)
{
  float4 AdaptiveDofDepthDownSampleParams : packoffset(c0);
  float4 AdaptiveDofParams0 : packoffset(c1);
  float4 AdaptiveDofParams1 : packoffset(c2);
  float4 AdaptiveDofParams2 : packoffset(c3);
  float4 AdaptiveDofParams3 : packoffset(c4);
  float4 AdaptiveDofFocusDistanceDampingParams1 : packoffset(c5);
  float4 AdaptiveDofFocusDistanceDampingParams2 : packoffset(c6);
  float4 QuadPosition : packoffset(c7);
  float4 QuadTexCoords : packoffset(c8);
  float4 QuadScale : packoffset(c9);
  float4 adapDOFProj : packoffset(c10);
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

SamplerState adaptiveDOFSamplerDepth_s : register(s3);
Texture2D<float4> adaptiveDOFSamplerDepth : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
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

  r0.xyzw = adaptiveDOFSamplerDepth.Sample(adaptiveDOFSamplerDepth_s, v1.xy).xyzw;
  r0.y = 1 + adapDOFProj.w;
  r0.x = r0.y + -r0.x;
  r0.x = adapDOFProj.z / r0.x;
  r0.y = min(AdaptiveDofDepthDownSampleParams.x, r0.x);
  r0.y = r0.y + -r0.x;
  r0.x = AdaptiveDofDepthDownSampleParams.z * r0.y + r0.x;
  r0.x = log2(r0.x);
  r0.x = AdaptiveDofDepthDownSampleParams.y * r0.x;
  o0.x = exp2(r0.x);
  return;
}