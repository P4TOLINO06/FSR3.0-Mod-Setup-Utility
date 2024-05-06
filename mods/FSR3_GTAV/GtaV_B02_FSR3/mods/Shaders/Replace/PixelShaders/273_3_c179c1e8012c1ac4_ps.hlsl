// ---- FNV Hash c179c1e8012c1ac4

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:29:54 2023
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb12 : register(b12)
{
  float4 cb12[1];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[5];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
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
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
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
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  bitmask.y = ((~(-1 << (uint)1)) << (uint)1) & 0xffffffff;  r0.y = (((uint)r0.y << (uint)1) & bitmask.y) | ((uint)0 & ~bitmask.y);
  bitmask.x = ((~(-1 << (uint)1)) << (uint)0) & 0xffffffff;  r0.x = (((uint)r0.x << (uint)0) & bitmask.x) | ((uint)r0.y & ~bitmask.x);
  r0.x = dot(cb2[0].xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  t0.GetDimensions(0, fDest.x, fDest.y, fDest.z);
  r1.xy = fDest.xy;
  r1.z = cmp(r0.y < r0.x);
  r2.xy = float2(2.86520004,2.95910001) * r0.yz;
  r1.w = cmp(r0.x < r2.x);
  r1.z = r1.w ? r1.z : 0;
  r1.w = cmp(r2.y < r0.y);
  r1.xy = cmp(r1.xy == float2(128,128));
  r1.xz = r1.yw ? r1.xz : 0;
  r1.x = r1.x ? r1.z : 0;
  r0.xz = r1.xx ? r0.yy : r0.xz;
  r0.yw = r0.yw;
  r1.x = cb2[12].x * r0.w;
  r1.x = cmp(cb5[4].x >= r1.x);
  if (r1.x != 0) discard;
  r1.x = cb12[0].x * r0.w;
  r1.x = cb2[12].w * r1.x;
  r1.x = cb2[13].y * r1.x;
  r0.w = v1.w * r0.w;
  r1.y = cb2[12].z * v1.x;
  r1.x = v1.z * r1.x;
  r1.z = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  r1.x = r1.x * r1.z;
  o3.z = saturate(0.0625 * r1.x);
  r0.w = cb2[13].y * r0.w;
  r0.w = cb2[12].x * r0.w;
  r1.x = 1 + -cb2[13].z;
  r1.x = cb5[3].z * r1.x;
  r1.x = r1.x * r1.y;
  r1.yz = float2(0.5,0.48828131) * r1.xx;
  r1.x = r1.x * -0.5 + 1;
  o0.xyz = r1.xxx * r0.xyz;
  o2.xy = sqrt(r1.yz);
  o0.w = r0.w;
  o2.zw = float2(0,0);
  o3.xy = float2(0,0);
  o3.w = r0.w;
  o1.xyzw = float4(0,0,0,0);
  return;
}