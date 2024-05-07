// ---- FNV Hash 471aa6f6a0f5f6f

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:29:54 2023
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb12 : register(b12)
{
  float4 cb12[2];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
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
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD7,
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
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(1.20000005 < cb2[13].w);
  r0.y = cmp(0.100000001 < v1.x);
  r0.x = r0.y ? r0.x : 0;
  r0.yz = cmp(v1.yz == v1.xx);
  r0.x = r0.y ? r0.x : 0;
  r0.x = r0.z ? r0.x : 0;
  r0.y = cb12[1].y * 10;
  r0.x = r0.x ? r0.y : cb12[1].y;
  r0.x = max(0.00100000005, r0.x);
  r0.y = dot(v6.xyz, v6.xyz);
  r0.y = rsqrt(r0.y);
  r0.yz = v6.xy * r0.yy;
  r1.xyzw = t3.Sample(s3_s, v2.xy).xyzw;
  r1.xy = cb12[0].yy * float2(0.5,0.001953125);
  r0.w = r1.w * cb12[0].y + -r1.x;
  r0.yz = r0.ww * r0.yz + v2.xy;
  r2.xyzw = t3.Sample(s3_s, r0.yz).xyzw;
  r3.xyzw = t0.Sample(s0_s, r0.yz).xyzw;
  r0.yz = r2.xy * float2(2,2) + float2(-1,-1);
  r0.xw = r0.yz * r0.xx;
  r0.y = dot(r0.yz, r0.yz);
  r0.y = 1 + -r0.y;
  r0.y = sqrt(abs(r0.y));
  r4.xyzw = v5.zxyz * r0.wwww;
  r4.xyzw = r0.xxxx * v4.zxyz + r4.xyzw;
  r0.xyzw = r0.yyyy * v3.zxyz + r4.xyzw;
  r1.x = dot(r0.yzw, r0.yzw);
  r1.x = rsqrt(r1.x);
  r0.x = r0.x * r1.x + -0.349999994;
  r0.yzw = r1.xxx * r0.yzw;
  o1.xyz = r0.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r0.y = -cb2[13].z + 1;
  r0.x = r0.x * r0.y;
  r0.x = cb2[12].z * r0.x;
  r0.y = dot(r2.xy, r2.xy);
  r0.y = cmp(r0.y >= 0.00200000009);
  r0.y = r0.y ? 1.000000 : 0;
  r0.z = cb12[1].x * r0.y;
  r0.w = r0.z * -0.5 + 1;
  r0.w = r0.x * r0.w;
  r0.w = r0.w * -0.5 + 1;
  r3.xyz = r3.xyz * r0.yyy;
  r4.xyz = v1.xyz * r0.yyy;
  r0.y = saturate(cb12[1].x * r0.y + 0.699999988);
  r5.xy = float2(0.5,0.48828131) * r0.yy;
  r4.w = v1.w;
  r3.xyzw = r4.xyzw * r3.xyzw;
  o0.xyz = r3.xyz * r0.www;
  r0.y = cb2[12].x * r3.w;
  r0.w = r3.w * r2.z;
  o1.w = cb2[12].x * r0.w;
  o0.w = r0.y;
  o2.w = r0.y;
  r2.x = -r0.z;
  r5.z = 0.970000029;
  r2.yz = cb12[0].yz * float2(-0.001953125,-1);
  r1.xzw = r5.xyz + r2.xyz;
  r1.xzw = max(float3(0,0,0), r1.xzw);
  r0.y = r1.x * r0.x + r0.z;
  o2.x = sqrt(r0.y);
  r0.y = r1.z * r0.x + r1.y;
  o2.z = r1.w * r0.x + cb12[0].z;
  o2.y = sqrt(r0.y);
  o3.xyzw = float4(0,0,0,0);
  return;
}