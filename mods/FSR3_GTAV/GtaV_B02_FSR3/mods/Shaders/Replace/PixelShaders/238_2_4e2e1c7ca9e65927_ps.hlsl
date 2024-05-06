// ---- FNV Hash 4e2e1c7ca9e65927

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

Texture2D<float4> LinearWrapTexture3 : register(t13);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
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
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.zw = float2(0,0);
  r1.xy = v0.xy + v0.xy;
  r1.xy = (int2)r1.xy;
  r0.xy = (int2)r1.xy + int2(-1,-1);
  r0.xyzw = LinearWrapTexture3.Load(r0.xyz).xyzw;
  r1.zw = float2(0,0);
  r2.xyzw = LinearWrapTexture3.Load(r1.xyz).xyzw;
  r1.xyzw = (int4)r1.xyxy + int4(0,-1,-1,0);
  r2.x = r2.y;
  r3.xy = r1.zw;
  r3.zw = float2(0,0);
  r3.xyzw = LinearWrapTexture3.Load(r3.xyz).xyzw;
  r2.y = r3.y;
  r1.zw = float2(0,0);
  r1.xyzw = LinearWrapTexture3.Load(r1.xyz).xyzw;
  r0.x = r1.y;
  r0.xy = r2.xy * r0.xy;
  r0.x = r0.x * r0.y;
  r0.x = cmp(r0.x != 0.000000);
  o0.xyzw = r0.xxxx ? float4(0,0,0,0) : float4(1,1,1,1);
  return;
}