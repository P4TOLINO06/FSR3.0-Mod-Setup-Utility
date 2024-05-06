// ---- FNV Hash 3dda2fd4fd82fe8f

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:20 2023

cbuffer im_cbuffer : register(b5)
{
  float4 TexelSize : packoffset(c0);
  float4 refMipBlurParams : packoffset(c1);
  float4 GeneralParams0 : packoffset(c2);
  float4 GeneralParams1 : packoffset(c3);
  float g_fBilateralCoefficient : packoffset(c4);
  float g_fBilateralEdgeThreshold : packoffset(c4.y);
  float DistantCarAlpha : packoffset(c4.z);
  float4 tonemapColorFilterParams0 : packoffset(c5);
  float4 tonemapColorFilterParams1 : packoffset(c6);
  float4 RenderTexMSAAParam : packoffset(c7);
  float4 RenderPointMapINTParam : packoffset(c8);
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

SamplerState NoiseSampler_s : register(s7);
Texture2D<float4> NoiseSampler : register(t7);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float3 v3 : TEXCOORD1,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000},
                              { 14, 0, 0, 0},
                              { 14, 0, 0, 0},
                              { 14, 0, 0, 0},
                              { 0x0000e00e, 0, 0, 0},
                              { 0x0000e00e, 0, 0, 0},
                              { 0x0000e00e, 0, 0, 0},
                              { 15, 0, 0, 0},
                              { 15, 0, 0, 0},
                              { 15, 0, 0, 0},
                              { 0x0000e00f, 0, 0, 0},
                              { 0x0000e00f, 0, 0, 0},
                              { 0x0000e00f, 0, 0, 0},
                              { 0x0000f00f, 0, 0, 0},
                              { 0x0000f00f, 0, 0, 0},
                              { 0x0000f00f, 0, 0, 0},
                              { 0x0000f0ef, 0, 0, 0},
                              { 0x0000f0ef, 0, 0, 0},
                              { 0x0000f0ef, 0, 0, 0},
                              { 0x0000feef, 0, 0, 0},
                              { 0x0000feef, 0, 0, 0},
                              { 0x0000feef, 0, 0, 0},
                              { 0x0000ff0f, 0, 0, 0},
                              { 0x0000ff0f, 0, 0, 0},
                              { 0x0000ff0f, 0, 0, 0},
                              { 0x0000ffef, 0, 0, 0},
                              { 0x0000ffef, 0, 0, 0},
                              { 0x0000ffef, 0, 0, 0},
                              { 0x0000ffff, 0, 0, 0},
                              { 0x0000ffff, 0, 0, 0},
                              { 0x0000ffff, 0, 0, 0} };
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 255 * v3.z;
  r0.x = (int)r0.x;
  r0.x = (uint)r0.x >> 3;
  r0.y = 15 & (int)icb[r0.x+2].x;
  r1.x = (uint)icb[r0.x+2].x >> 4;
  r1.y = (uint)icb[r0.x+2].x >> 8;
  r0.x = (uint)icb[r0.x+2].x >> 12;
  r0.zw = (int2)r1.xy & int2(15,15);
  r0.xy = (int2)r0.xy;
  r1.x = 0.0666666701 * r0.y;
  r0.yz = (int2)r0.zw;
  r1.yzw = float3(0.0666666701,0.0666666701,0.0666666701) * r0.yzx;
  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(r1.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = NoiseSampler.Sample(NoiseSampler_s, v3.xy).xyzw;
  r1.x = cmp(GeneralParams0.x < 1);
  r2.xyz = v1.xyz;
  r2.w = 1;
  r2.xyzw = r2.xyzw * r0.xyzw;
  r0.xyzw = r1.xxxx ? r2.xyzw : r0.xyzw;
  r1.x = GeneralParams0.x * r0.x;
  o3.z = 0.5 * r1.x;
  o0.xyzw = r0.xyzw;
  o1.xyz = v2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  o1.w = 1;
  o2.xyzw = float4(0.800000012,0.200000003,0.949999988,0.939999998);
  o3.xyw = float3(0.649999976,0.5,1);
  return;
}