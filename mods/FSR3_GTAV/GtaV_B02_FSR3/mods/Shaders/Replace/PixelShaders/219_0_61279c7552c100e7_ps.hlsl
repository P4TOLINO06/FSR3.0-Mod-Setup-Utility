// ---- FNV Hash 61279c7552c100e7

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer waterTex_locals : register(b11)
{
  float4 WaterBumpParams[2] : packoffset(c0);
  float4 gProjParams : packoffset(c2);
  float4 gFogCompositeParams : packoffset(c3);
  float4 gFogCompositeAmbientColor : packoffset(c4);
  float4 gFogCompositeDirectionalColor : packoffset(c5);
  float4 gFogCompositeTexOffset : packoffset(c6);
  float4 UpdateParams0 : packoffset(c7);
  float4 UpdateParams1 : packoffset(c8);
  float4 UpdateParams2 : packoffset(c9);
  float4 UpdateOffset : packoffset(c10);
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

SamplerState LinearWrapSampler_s : register(s11);
SamplerState HeightMapSampler_s : register(s14);
SamplerState VelocityMapSampler_s : register(s15);
Texture2D<float4> LinearWrapSampler : register(t11);
Texture2D<float4> HeightMapSampler : register(t14);
Texture2D<float4> VelocityMapSampler : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = UpdateOffset.zwzw + v2.xyxy;
  r1.xyzw = float4(0.00390625,0.00390625,-0.00390625,-0.00390625) + r0.zwzw;
  r2.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r1.xy).xyzw;
  r1.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r1.zw).xyzw;
  r2.y = r1.x;
  r1.xyzw = float4(-0.00390625,0.00390625,0.00390625,-0.00390625) + r0.xyzw;
  r3.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r1.xy).xyzw;
  r1.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r1.zw).xyzw;
  r2.w = r1.x;
  r2.z = r3.x;
  r1.xyzw = float4(0.0700000003,0.0700000003,0.0700000003,0.0700000003) * r2.xyzw;
  r2.xyzw = float4(0.00390625,0,0,0.00390625) + r0.zwzw;
  r3.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r2.xy).xyzw;
  r2.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r2.zw).xyzw;
  r3.y = r2.x;
  r2.xyzw = float4(-0.00390625,0,0,-0.00390625) + r0.zwzw;
  r4.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r2.xy).xyzw;
  r2.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r2.zw).xyzw;
  r3.w = r2.x;
  r3.z = r4.x;
  r1.xyzw = r3.xyzw * float4(0.180000007,0.180000007,0.180000007,0.180000007) + r1.xyzw;
  r0.x = r1.x + r1.y;
  r0.x = r0.x + r1.z;
  r0.x = r0.x + r1.w;
  r1.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, r0.zw).xyzw;
  r0.x = r1.x + -r0.x;
  r1.yz = r0.zw * float2(8,8) + UpdateParams1.ww;
  r2.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r1.yz).xyzw;
  r0.y = -0.492156863 + r2.x;
  r0.y = UpdateParams0.w * r0.y;
  r2.xyzw = VelocityMapSampler.Sample(VelocityMapSampler_s, r0.zw).xyzw;
  r0.zw = r0.zw + r0.zw;
  r0.zw = UpdateOffset.xy * float2(0.001953125,0.001953125) + r0.zw;
  r0.y = r0.y * UpdateParams0.x + r2.x;
  r1.y = UpdateParams1.y * UpdateParams0.x;
  r2.y = r0.w * UpdateParams1.x + UpdateParams0.z;
  r3.xyzw = float4(40,0.5,-0.514573157,2.49999994e-06) * UpdateParams0.xxxy;
  r2.x = r0.z * UpdateParams1.x + r3.w;
  r2.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r2.xy).xyzw;
  r0.z = -0.492156863 + r2.x;
  r0.y = r0.z * r1.y + r0.y;
  r0.x = -r0.x * r3.x + r0.y;
  r0.x = -r1.x * r3.y + r0.x;
  r0.y = exp2(r3.z);
  r0.x = r0.x * r0.y;
  r0.x = max(-10, r0.x);
  r0.x = min(10, r0.x);
  r0.y = cmp(abs(r0.x) >= 9);
  o0.x = r0.y ? 0 : r0.x;
  return;
}