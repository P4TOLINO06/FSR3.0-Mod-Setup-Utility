// ---- FNV Hash 2e2e0be506425faf

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 DynamicScaling : packoffset(c6);
  float4 Parameters01 : packoffset(c7);
  float4 Parameters02 : packoffset(c8);
  float4 Parameters03 : packoffset(c9);
  float4 Parameters04 : packoffset(c10);
  float4 Parameters05 : packoffset(c11);
  float4 Parameters06 : packoffset(c12);
  float4 Parameters07 : packoffset(c13);
  float4 Parameters08 : packoffset(c14);
  float4 Matrix01[4] : packoffset(c15);
  float4 Matrix02[4] : packoffset(c19);
  float4 Matrix03[4] : packoffset(c23);
  float4 Matrix04[4] : packoffset(c27);
  float4 Matrix05[4] : packoffset(c31);
  float SSAOsplitcount : packoffset(c35) = {2};
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

SamplerState Sampler8_s : register(s8);
Texture2D<float4> Texture2 : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
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

  r0.y = Parameters01.y * Parameters01.z;
  r0.x = Parameters01.y;
  r1.xyzw = r0.xyxy * float4(-0.499000013,0,0.499000013,0) + v1.xyxy;
  r0.xyzw = r0.xyxy * float4(0,-0.499000013,0,0.499000013) + v1.xyxy;
  r0.xyzw = SSAOsplitcount * r0.xyzw;
  r1.xyzw = SSAOsplitcount * r1.xyzw;
  r2.xyzw = floor(r1.xyzw);
  r3.y = Parameters05.y * Parameters05.z;
  r3.x = Parameters05.y;
  r1.xyzw = r2.xyzw * r3.xyxy + r1.xyzw;
  r1.xyzw = r3.xyxy * float4(0.5,0.5,0.5,0.5) + r1.xyzw;
  r1.xyzw = frac(r1.xyzw);
  r2.xyzw = Texture2.Sample(Sampler8_s, r1.xy).xyzw;
  r1.xyzw = Texture2.Sample(Sampler8_s, r1.zw).yxzw;
  r1.x = r2.x;
  r2.x = min(r1.x, r1.y);
  r4.xyzw = floor(r0.xyzw);
  r0.xyzw = r4.xyzw * r3.xyxy + r0.xyzw;
  r0.xyzw = r3.xyxy * float4(0.5,0.5,0.5,0.5) + r0.xyzw;
  r0.xyzw = frac(r0.xyzw);
  r4.xyzw = Texture2.Sample(Sampler8_s, r0.xy).xyzw;
  r0.xyzw = Texture2.Sample(Sampler8_s, r0.zw).xyzw;
  r1.z = r4.x;
  r0.y = min(r4.x, r2.x);
  r0.y = min(r0.y, r0.x);
  r1.w = r0.x;
  r0.x = dot(r1.xyzw, float4(0.25,0.25,0.25,0.25));
  r0.x = 1 + -r0.x;
  r0.x = max(1.00000002e-16, r0.x);
  r0.x = 1 / r0.x;
  r0.zw = SSAOsplitcount * v1.xy;
  r1.xy = floor(r0.zw);
  r0.zw = r1.xy * r3.xy + r0.zw;
  r0.zw = r3.xy * float2(0.5,0.5) + r0.zw;
  r0.zw = frac(r0.zw);
  r1.xyzw = Texture2.Sample(Sampler8_s, r0.zw).xyzw;
  r0.z = 1 + -r1.x;
  r0.z = max(1.00000002e-16, r0.z);
  r0.z = 1 / r0.z;
  r0.x = r0.z + -r0.x;
  r0.x = 0.430000007 * abs(r0.x);
  r0.x = min(1, r0.x);
  r0.y = -r1.x + r0.y;
  r0.x = r0.x * r0.y + r1.x;
  r0.x = 1 + -r0.x;
  r0.x = max(1.00000002e-16, r0.x);
  r0.x = 1 / r0.x;
  o0.xyzw = float4(1.00100005,1.00100005,1.00100005,1.00100005) * r0.xxxx;
  return;
}