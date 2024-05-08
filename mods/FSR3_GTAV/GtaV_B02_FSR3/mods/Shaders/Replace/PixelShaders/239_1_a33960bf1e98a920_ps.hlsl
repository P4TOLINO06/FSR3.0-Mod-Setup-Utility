// ---- FNV Hash a33960bf1e98a920

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer EConstantList0 : register(b0)
{
  float4 cb0[512] : packoffset(c0);
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

SamplerState Sampler5_s : register(s5);
SamplerState Sampler6_s : register(s6);
Texture2D<float4> Texture5 : register(t5);
Texture2D<float4> Texture6 : register(t6);


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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v2.xy + v1.xy;
  r0.xyzw = Texture6.Sample(Sampler6_s, r0.xy).xyzw;
  r0.x = r0.y * 2 + -1;
  r0.yzw = float3(0.00390629983,0.00390629983,-0.00390629983) + v1.xyy;
  r1.xyzw = Texture5.Sample(Sampler5_s, r0.yz).xywz;
  r2.xyzw = Texture5.Sample(Sampler5_s, r0.yw).xyzw;
  r1.y = r2.x;
  r0.yzw = float3(-0.00390629983,-0.00390629983,0.00390629983) + v1.xyy;
  r2.xyzw = Texture5.Sample(Sampler5_s, r0.yz).xyzw;
  r3.xyzw = Texture5.Sample(Sampler5_s, r0.yw).xyzw;
  r1.z = r3.x;
  r1.w = r2.x;
  r2.xyzw = float4(0.0700000003,0.0700000003,0.0700000003,0.0700000003) * r1.xywz;
  r3.yw = r1.xy;
  r4.xyzw = float4(0.00390629983,0,0,0.00390629983) + v1.xyxy;
  r5.xyzw = Texture5.Sample(Sampler5_s, r4.xy).xyzw;
  r4.xyzw = Texture5.Sample(Sampler5_s, r4.zw).xyzw;
  r5.y = r4.x;
  r4.xyzw = float4(-0.00390629983,0,0,-0.00390629983) + v1.xyxy;
  r6.xyzw = Texture5.Sample(Sampler5_s, r4.xy).xyzw;
  r4.xyzw = Texture5.Sample(Sampler5_s, r4.zw).xyzw;
  r5.w = r4.x;
  r5.z = r6.x;
  r2.xyzw = r5.xyzw * float4(0.180000007,0.180000007,0.180000007,0.180000007) + r2.xyzw;
  r0.y = dot(r2.xyzw, float4(1,1,1,1));
  r2.xyzw = Texture5.Sample(Sampler5_s, v1.xy).xyzw;
  r0.y = -r2.x + r0.y;
  r0.y = cb0[0].x * r0.y;
  r0.z = 0.5 + -r2.x;
  r0.y = r0.z * cb0[0].y + r0.y;
  r0.x = r0.x * cb0[1].y + r0.y;
  r0.x = cb0[0].w * r0.x;
  r0.y = cb0[1].w * r0.x;
  r0.x = cb0[1].w * r0.x + r2.y;
  r0.z = -0.5 + r2.y;
  r0.yz = cb0[1].wx * r0.yz;
  r0.z = cb0[1].w * r0.z;
  r0.y = r0.y * 0.5 + r0.z;
  r0.y = r0.y + r2.x;
  r3.x = r2.x;
  o0.xyz = min(r0.yyy, r0.xxx);
  o0.w = 1;
  r0.xyzw = min(r5.xyzw, r3.xyxw);
  r1.xy = r3.yx;
  r2.xyw = r3.wxx;
  r0.xyzw = min(r1.xyzy, r0.xyzw);
  r0.xyzw = min(r0.xyzw, r1.yzyw);
  r2.z = r1.w;
  r0.xyzw = min(r0.xyzw, r2.xyzw);
  o1.xyz = dot(r0.xyzw, float4(0.25,0.25,0.25,0.25));
  o1.w = 1;
  return;
}