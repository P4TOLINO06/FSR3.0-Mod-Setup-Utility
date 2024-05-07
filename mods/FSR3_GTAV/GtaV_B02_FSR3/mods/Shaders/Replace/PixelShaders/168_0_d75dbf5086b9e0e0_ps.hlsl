// ---- FNV Hash d75dbf5086b9e0e0

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer _Globals : register(b0)
{
  float EFalloff : packoffset(c0) = {0};
  int EFalloffType : packoffset(c0.y) = {0};
  float EOctaveWeight1 : packoffset(c0.z) = {0.0270000007};
  float EOctaveWeight2 : packoffset(c0.w) = {0.109999999};
  float EOctaveWeight3 : packoffset(c1) = {0.25};
  float EOctaveWeight4 : packoffset(c1.y) = {0.439999998};
  float EOctaveWeight5 : packoffset(c1.z) = {0.699999988};
  float EOctaveWeight6 : packoffset(c1.w) = {1};
  float4 Timer : packoffset(c2);
  float4 ScreenSize : packoffset(c3);
  float AdaptiveQuality : packoffset(c4);
  float4 Weather : packoffset(c5);
  float4 TimeOfDay1 : packoffset(c6);
  float4 TimeOfDay2 : packoffset(c7);
  float ENightDayFactor : packoffset(c8);
  float EInteriorFactor : packoffset(c8.y);
  float4 tempF1 : packoffset(c9);
  float4 tempF2 : packoffset(c10);
  float4 tempF3 : packoffset(c11);
  float4 tempInfo1 : packoffset(c12);
  float4 tempInfo2 : packoffset(c13);
  float4 BloomSize : packoffset(c14);
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

SamplerState Sampler1_s : register(s0);
Texture2D<float4> TextureDownsampled : register(t0);


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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 4 * ScreenSize.z;
  r0.x = min(16, r0.x);
  r0.x = max(2, r0.x);
  r0.y = 0.499900013 + r0.x;
  r0.y = (int)r0.y;
  r0.x = 1 / r0.x;
  r1.x = 2;
  r1.y = ScreenSize.z;
  r0.zw = float2(0.00390625,0.0078125) * r1.xy;
  r1.x = r0.x * 0.5 + -0.5;
  r1.yzw = float3(0,0,0);
  r2.xyz = float3(9.99999997e-07,-0.375,0);
  while (true) {
    r2.w = cmp((int)r2.z >= 4);
    if (r2.w != 0) break;
    r3.x = r2.y;
    r4.xyz = r1.yzw;
    r2.w = r2.x;
    r3.z = r1.x;
    r3.w = 0;
    while (true) {
      r4.w = cmp((int)r3.w >= (int)r0.y);
      if (r4.w != 0) break;
      r3.y = r3.z;
      r5.xy = r3.xy * r0.zw + v1.xy;
      r5.xyz = TextureDownsampled.Sample(Sampler1_s, r5.xy).xyz;
      r6.xy = r3.xy + r3.xy;
      r3.y = dot(r6.xy, r6.xy);
      r4.w = saturate(-r3.y * 1000 + 1001);
      r3.y = 1 + -r3.y;
      r3.y = max(0, r3.y);
      r5.w = r4.w * r3.y;
      r4.xyz = r5.xyz * r5.www + r4.xyz;
      r2.w = r4.w * r3.y + r2.w;
      r3.z = r3.z + r0.x;
      r3.w = (int)r3.w + 1;
    }
    r1.yzw = r4.xyz;
    r2.x = r2.w;
    r2.y = 0.25 + r2.y;
    r2.z = (int)r2.z + 1;
  }
  r0.x = 1 / r2.x;
  r0.xyz = r1.yzw * r0.xxx;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  o0.xyz = min(float3(32768,32768,32768), r0.xyz);
  o0.w = 1;
  return;
}