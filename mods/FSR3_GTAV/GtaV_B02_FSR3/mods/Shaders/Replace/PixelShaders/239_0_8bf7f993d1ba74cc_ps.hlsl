// ---- FNV Hash 8bf7f993d1ba74cc

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

SamplerState HeightSampler_s : register(s5);
SamplerState NoiseSampler_s : register(s6);
Texture2D<float4> HeightSampler : register(t5);
Texture2D<float4> NoiseSampler : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v2.xy + v1.xy;
  r0.xyzw = NoiseSampler.Sample(NoiseSampler_s, r0.xy).xyzw;
  r0.x = r0.y * 2 + -1;
  r1.xyzw = float4(0.00390625,0,0,0.00390625) + v1.xyxy;
  r2.xyzw = HeightSampler.Sample(HeightSampler_s, r1.xy).xyzw;
  r1.xyzw = HeightSampler.Sample(HeightSampler_s, r1.zw).xyzw;
  r2.y = r1.x;
  r1.xyzw = float4(-0.00390625,0,0,-0.00390625) + v1.xyxy;
  r3.xyzw = HeightSampler.Sample(HeightSampler_s, r1.xy).xyzw;
  r1.xyzw = HeightSampler.Sample(HeightSampler_s, r1.zw).xyzw;
  r2.w = r1.x;
  r2.z = r3.x;
  r1.xyzw = float4(-0.00390625,-0.00390625,-0.00390625,0.00390625) + v1.xyxy;
  r3.xyzw = HeightSampler.Sample(HeightSampler_s, r1.xy).yzwx;
  r1.xyzw = HeightSampler.Sample(HeightSampler_s, r1.zw).yzxw;
  r4.z = r3.w;
  r5.xyzw = float4(0.00390625,0.00390625,0.00390625,-0.00390625) + v1.xyxy;
  r6.xyzw = HeightSampler.Sample(HeightSampler_s, r5.zw).yzwx;
  r5.xyzw = HeightSampler.Sample(HeightSampler_s, r5.xy).xyzw;
  r6.y = r5.x;
  r5.xyzw = HeightSampler.Sample(HeightSampler_s, v1.xy).xyzw;
  r6.z = r5.x;
  r4.xy = r6.wz;
  r7.yz = r4.xz;
  r1.xw = r6.yz;
  r7.xw = r1.xz;
  r7.xyzw = float4(0.0700000003,0.0700000003,0.0700000003,0.0700000003) * r7.xyzw;
  r7.xyzw = r2.xyzw * float4(0.180000007,0.180000007,0.180000007,0.180000007) + r7.xyzw;
  r0.y = dot(r7.xyzw, float4(1,1,1,1));
  r0.y = r0.y + -r5.x;
  r0.y = WaterBumpParams[0].x * r0.y;
  r0.z = 0.5 + -r5.x;
  r0.y = r0.z * WaterBumpParams[0].y + r0.y;
  r0.x = r0.x * WaterBumpParams[1].y + r0.y;
  r0.x = WaterBumpParams[0].w * r0.x;
  r0.y = WaterBumpParams[1].w * r0.x;
  o0.y = r0.x * WaterBumpParams[1].w + r5.y;
  r0.x = WaterBumpParams[1].w * r0.y;
  r0.y = -0.5 + r5.y;
  r0.y = WaterBumpParams[1].x * r0.y;
  r0.y = r0.y * WaterBumpParams[1].w + r5.x;
  o0.x = r0.x * 0.5 + r0.y;
  o0.zw = float2(1,1);
  r0.xyzw = float4(0.0078125,0,0,0.0078125) + v1.xyxy;
  r5.xyzw = HeightSampler.Sample(HeightSampler_s, r0.xy).xyzw;
  r0.xyzw = HeightSampler.Sample(HeightSampler_s, r0.zw).xyzw;
  r1.y = r0.x;
  r6.x = r5.x;
  r0.xyzw = min(r6.xyzw, r2.xyzw);
  r0.xyzw = min(r0.xyzw, r1.xyzw);
  r3.xy = r1.wz;
  r1.xyzw = float4(-0.0078125,0,0,-0.0078125) + v1.xyxy;
  r2.xyzw = HeightSampler.Sample(HeightSampler_s, r1.xy).xyzw;
  r1.xyzw = HeightSampler.Sample(HeightSampler_s, r1.zw).xyzw;
  r4.w = r1.x;
  r3.z = r2.x;
  r0.xyzw = min(r0.xyzw, r3.xyzw);
  r0.xyzw = min(r0.xyzw, r4.xyzw);
  r0.xy = r0.zw + -r0.xy;
  o1.xy = r0.xy * float2(3,3) + float2(0.5,0.5);
  o1.zw = float2(1,1);
  return;
}