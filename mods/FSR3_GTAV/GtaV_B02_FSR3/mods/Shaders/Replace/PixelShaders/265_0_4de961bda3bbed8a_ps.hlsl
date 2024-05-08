// ---- FNV Hash 4de961bda3bbed8a

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t13 : register(t13);

Texture2D<float4> t0 : register(t0);

SamplerState s13_s : register(s13);

SamplerState s0_s : register(s0);

cbuffer cb5 : register(b5)
{
  float4 cb5[88];
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



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  float v3 : DEPTH0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
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

  r0.x = t0.Sample(s0_s, v1.xy).y;
  r0.x = max(cb5[87].y, r0.x);
  r0.x = min(cb5[87].x, r0.x);
  r0.x = abs(cb5[87].y) + r0.x;
  r0.y = cb5[87].x + -cb5[87].y;
  r0.x = r0.x / r0.y;
  r0.x = r0.x * -15 + 15;
  r0.x = trunc(r0.x);
  r0.yz = float2(4,0.25) * r0.xx;
  r0.y = cmp(r0.y >= -r0.y);
  r0.yw = r0.yy ? float2(4,0.25) : float2(-4,-0.25);
  r0.x = r0.x * r0.w;
  r0.x = frac(r0.x);
  r0.x = r0.y * r0.x;
  r0.xz = trunc(r0.xz);
  r0.yw = float2(0.25,0.25) * v1.xy;
  r0.x = r0.x * 0.25 + r0.y;
  r0.y = r0.z * 0.25 + r0.w;
  r0.xyz = t13.Sample(s13_s, r0.xy).yxz;
  r0.xyzw = v2.xyzw * r0.zxyx;
  o0.xyzw = float4(0.200000003,0.200000003,0.200000003,0.200000003) * r0.xyzw;
  return;
}