// ---- FNV Hash 4286561c827a7ff7

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

cbuffer cb2 : register(b2)
{
  float4 cb2[15];
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
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t7.Sample(s7_s, v1.xy, int2(-1, -1)).xyzw;
  r1.xyzw = t7.Sample(s7_s, v1.xy).xyzw;
  r0.x = -r1.x + r0.x;
  r0.x = 142.857101 * abs(r0.x);
  r0.x = r0.x * r0.x;
  r0.x = -0.721347511 * r0.x;
  r0.x = exp2(r0.x);
  r0.y = 1 + r0.x;
  r2.xyzw = t7.Sample(s7_s, v1.xy, int2(-1, 0)).xyzw;
  r0.z = r2.x + -r1.x;
  r0.z = 142.857101 * abs(r0.z);
  r0.z = r0.z * r0.z;
  r0.z = -0.721347511 * r0.z;
  r0.z = exp2(r0.z);
  r0.y = r0.y + r0.z;
  r2.xyzw = t7.Sample(s7_s, v1.xy, int2(-1, 1)).xyzw;
  r0.w = r2.x + -r1.x;
  r0.w = 142.857101 * abs(r0.w);
  r0.w = r0.w * r0.w;
  r0.w = -0.721347511 * r0.w;
  r0.w = exp2(r0.w);
  r0.y = r0.y + r0.w;
  r2.xyzw = t7.Sample(s7_s, v1.xy, int2(0, -1)).xyzw;
  r1.y = r2.x + -r1.x;
  r1.y = 142.857101 * abs(r1.y);
  r1.y = r1.y * r1.y;
  r1.y = -0.721347511 * r1.y;
  r1.y = exp2(r1.y);
  r0.y = r1.y + r0.y;
  r2.xyzw = t7.Sample(s7_s, v1.xy, int2(0, 1)).xyzw;
  r1.z = r2.x + -r1.x;
  r1.z = 142.857101 * abs(r1.z);
  r1.z = r1.z * r1.z;
  r1.z = -0.721347511 * r1.z;
  r1.z = exp2(r1.z);
  r0.y = r1.z + r0.y;
  r2.xyzw = t7.Sample(s7_s, v1.xy, int2(1, -1)).xyzw;
  r1.w = r2.x + -r1.x;
  r1.w = 142.857101 * abs(r1.w);
  r1.w = r1.w * r1.w;
  r1.w = -0.721347511 * r1.w;
  r1.w = exp2(r1.w);
  r0.y = r1.w + r0.y;
  r2.xyzw = t7.Sample(s7_s, v1.xy, int2(1, 0)).xyzw;
  r2.x = r2.x + -r1.x;
  r2.x = 142.857101 * abs(r2.x);
  r2.x = r2.x * r2.x;
  r2.x = -0.721347511 * r2.x;
  r2.x = exp2(r2.x);
  r0.y = r2.x + r0.y;
  r3.xyzw = t7.Sample(s7_s, v1.xy, int2(1, 1)).xyzw;
  r1.x = r3.x + -r1.x;
  r1.x = 142.857101 * abs(r1.x);
  r1.x = r1.x * r1.x;
  r1.x = -0.721347511 * r1.x;
  r1.x = exp2(r1.x);
  r0.y = r1.x + r0.y;
  r3.xyzw = t6.Sample(s6_s, v1.xy).xyzw;
  r2.yzw = cb2[14].www * r3.xyz;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(-1, -1)).xyzw;
  r4.xyz = cb2[14].www * r4.xyz;
  r2.yzw = r4.xyz * r0.xxx + r2.yzw;
  r3.xyz = r3.xyz * cb2[14].www + r4.xyz;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(-1, 0)).xyzw;
  r5.xyz = cb2[14].www * r4.xyz;
  r3.xyz = r4.xyz * cb2[14].www + r3.xyz;
  r2.yzw = r5.xyz * r0.zzz + r2.yzw;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(-1, 1)).xyzw;
  r5.xyz = cb2[14].www * r4.xyz;
  r3.xyz = r4.xyz * cb2[14].www + r3.xyz;
  r0.xzw = r5.xyz * r0.www + r2.yzw;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(0, -1)).xyzw;
  r2.yzw = cb2[14].www * r4.xyz;
  r3.xyz = r4.xyz * cb2[14].www + r3.xyz;
  r0.xzw = r2.yzw * r1.yyy + r0.xzw;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(0, 1)).xyzw;
  r2.yzw = cb2[14].www * r4.xyz;
  r3.xyz = r4.xyz * cb2[14].www + r3.xyz;
  r0.xzw = r2.yzw * r1.zzz + r0.xzw;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(1, -1)).xyzw;
  r2.yzw = cb2[14].www * r4.xyz;
  r3.xyz = r4.xyz * cb2[14].www + r3.xyz;
  r0.xzw = r2.yzw * r1.www + r0.xzw;
  r4.xyzw = t6.Sample(s6_s, v1.xy, int2(1, 0)).xyzw;
  r1.yzw = cb2[14].www * r4.xyz;
  r2.yzw = r4.xyz * cb2[14].www + r3.xyz;
  r0.xzw = r1.yzw * r2.xxx + r0.xzw;
  r3.xyzw = t6.Sample(s6_s, v1.xy, int2(1, 1)).xyzw;
  r1.yzw = cb2[14].www * r3.xyz;
  r2.xyz = r3.xyz * cb2[14].www + r2.yzw;
  r2.xyz = float3(0.111111097,0.111111097,0.111111097) * r2.xyz;
  r0.xzw = r1.yzw * r1.xxx + r0.xzw;
  r0.xzw = r0.xzw / r0.yyy;
  r0.y = cmp(r0.y < 3);
  r0.xyz = r0.yyy ? r2.xyz : r0.xzw;
  o0.xyz = cb2[14].zzz * r0.xyz;
  o0.w = 1;
  return;
}