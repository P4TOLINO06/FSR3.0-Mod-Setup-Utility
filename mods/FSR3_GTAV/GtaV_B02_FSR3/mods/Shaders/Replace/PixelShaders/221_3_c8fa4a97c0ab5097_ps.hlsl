// ---- FNV Hash c8fa4a97c0ab5097

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
Texture2D<float4> LinearWrapSampler : register(t11);
Texture2D<float4> HeightMapSampler : register(t14);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
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

  r0.xyzw = UpdateOffset.zwzw + v1.xyxy;
  r1.xyzw = float4(0.00390625,0,0,0.00390625) + r0.zwzw;
  r2.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r1.xy).yxzw;
  r1.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r1.zw).xyzw;
  r3.x = r2.y;
  r3.y = r1.x;
  r2.y = r1.y;
  r1.xyzw = float4(-0.00390625,0,0,-0.00390625) + r0.xyzw;
  r0.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r0.zw).xyzw;
  r4.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r1.xy).xyzw;
  r1.xyzw = LinearWrapSampler.Sample(LinearWrapSampler_s, r1.zw).xyzw;
  r3.z = r4.x;
  r2.z = r4.y;
  r3.w = r1.x;
  r2.w = r1.y;
  r1.y = dot(r2.xyzw, float4(0.25,0.25,0.25,0.25));
  r1.x = dot(r3.xyzw, float4(0.25,0.25,0.25,0.25));
  r0.zw = r1.xy + -r0.xy;
  r1.xyz = float3(2.5,5,0.150000006) * UpdateParams0.xxx;
  r1.xy = saturate(r1.xy);
  r0.xy = r1.xy * r0.zw + r0.xy;
  r0.z = r1.z * -r0.y + r0.y;
  r1.xyzw = HeightMapSampler.Sample(HeightMapSampler_s, v1.xy).xyzw;
  r0.y = -0.100000001 + r1.x;
  r1.xz = float2(0.5,0.5) * r1.xx;
  r0.y = max(0, r0.y);
  r0.y = min(2, r0.y);
  r1.yw = UpdateParams0.yy * r0.yy;
  r2.xyzw = cmp(r1.zwzw >= r0.xzxz);
  r1.xyzw = r1.xyzw + -r0.xzxz;
  r2.xyzw = r2.xyzw ? float4(1,1,1,1) : 0;
  r3.xyzw = saturate(float4(1,3,1,3) * UpdateParams0.xxxx);
  r3.xyzw = float4(-0.00999999978,-0.00100000005,-0.00999999978,-0.00100000005) + r3.xyzw;
  r2.xyzw = r2.xyzw * r3.xyzw + float4(0.00999999978,0.00100000005,0.00999999978,0.00100000005);
  o0.xyzw = r2.xyzw * r1.xyzw + r0.xzxz;
  return;
}