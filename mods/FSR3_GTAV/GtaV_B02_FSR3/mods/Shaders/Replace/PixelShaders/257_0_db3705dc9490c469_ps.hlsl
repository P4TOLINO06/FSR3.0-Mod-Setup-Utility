// ---- FNV Hash db3705dc9490c469

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb12 : register(b12)
{
  float4 cb12[1];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[46];
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
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  t0.GetDimensions(0, fDest.x, fDest.y, fDest.z);
  r0.xy = fDest.xy;
  r0.xy = cmp(r0.xy == float2(128,128));
  r0.x = r0.y ? r0.x : 0;
  r1.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.yz = float2(2.86520004,2.95910001) * r1.yz;
  r0.y = cmp(r1.x < r0.y);
  r0.z = cmp(r0.z < r1.y);
  r0.w = cmp(r1.y < r1.x);
  r0.y = r0.y ? r0.w : 0;
  r0.y = r0.z ? r0.y : 0;
  r0.x = r0.x ? r0.y : 0;
  r1.xz = r0.xx ? r1.yy : r1.xz;
  r0.x = dot(v3.xyz, v3.xyz);
  r0.x = rsqrt(r0.x);
  r0.y = v3.z * r0.x + -0.349999994;
  r0.xzw = v3.xyz * r0.xxx;
  o1.xyz = r0.xzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = saturate(1.53846204 * r0.y);
  r0.x = cb5[3].z * r0.x;
  r0.y = -cb2[13].z + 1;
  r0.x = r0.x * r0.y;
  r2.yz = cb2[12].zy * v1.xy;
  r0.x = r2.y * r0.x;
  r0.y = r0.x * -0.5 + 1;
  r0.xz = float2(0.5,0.48828131) * r0.xx;
  o2.xy = sqrt(r0.xz);
  o0.xyz = r1.xyz * r0.yyy;
  r0.x = v1.w * r1.w;
  r0.y = cb12[0].x * r1.w;
  r0.y = cb2[12].w * r0.y;
  r0.y = v1.z * r0.y;
  o3.z = saturate(0.0625 * r0.y);
  o0.w = cb2[12].x * r0.x;
  o1.w = saturate(v3.z * 128 + -127);
  o2.zw = float2(0.980000019,1);
  r2.x = cb2[12].z * v1.x + cb3[45].w;
  r0.xy = float2(0.5,0.5) * r2.xz;
  o3.xy = sqrt(r0.xy);
  o3.w = 1;
  return;
}