// ---- FNV Hash 74213c43a788df93

// ---- Created with 3Dmigoto v1.3.16 on Sat Mar  9 08:17:12 2024
cbuffer cb4 : register(b4)
{
  float4 cb4[8];
}

cbuffer cb8 : register(b8)
{
  float4 cb8[2];
}

cbuffer cb7 : register(b7)
{
  float4 cb7[1];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[22];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
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
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float2 v3 : TEXCOORD1,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float4 o6 : TEXCOORD5,
  out float4 o7 : TEXCOORD7,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cb8[0].x * v0.x;
  r1.xyzw = cb4[1].zxyz * v0.yyyy;
  r1.xyzw = v0.xxxx * cb4[0].zxyz + r1.xyzw;
  r1.xyzw = v0.zzzz * cb4[2].zxyz + r1.xyzw;
  r1.xyzw = cb4[3].zxyz + r1.xyzw;
  r0.y = cb8[1].y + 0.0299999993;
  r0.z = r0.y + -r1.x;
  r0.y = cmp(r1.w < r0.y);
  r0.z = cb8[1].z * r0.z;
  r0.z = min(1, r0.z);
  r2.xyz = cb8[1].www * v0.xyz;
  r0.w = -cb8[0].w * r0.z + r2.x;
  r3.x = r0.x * r0.z + r0.w;
  r0.x = cb8[1].y + -r1.x;
  o4.xyz = cb1[15].xyz + -r1.yzw;
  r0.x = max(0, r0.x);
  r3.yz = cb8[0].yz * r0.xx + r2.yz;
  r0.xyz = r0.yyy ? r3.xyz : r2.xyz;
  r0.w = cb8[1].x * 1.10000002;
  r0.w = r0.w * r0.w;
  r1.x = dot(v0.yz, v0.yz);
  r1.y = cb8[1].w * r1.x;
  r0.w = cmp(r0.w < r1.y);
  r0.xyz = r0.www ? r0.xyz : r2.xyz;
  r0.w = cb8[1].x * cb8[1].x;
  r0.w = cmp(r0.w < r1.x);
  r0.xyz = r0.www ? r0.xyz : v0.xyz;
  r0.xyz = cb7[0].xxx ? r0.xyz : v0.xyz;
  r1.xyzw = cb4[5].xyzw * r0.yyyy;
  r1.xyzw = r0.xxxx * cb4[4].xyzw + r1.xyzw;
  r0.xyzw = r0.zzzz * cb4[6].xyzw + r1.xyzw;
  o0.xyzw = cb4[7].xyzw + r0.xyzw;
  o1.xy = v2.xy;
  o1.zw = v3.xy;
  r0.xyz = cb4[1].xyz * v4.yyy;
  r0.xyz = v4.xxx * cb4[0].xyz + r0.xyz;
  r0.xyz = v4.zzz * cb4[2].xyz + r0.xyz;
  o2.xyz = r0.xyz;
  o3.xyzw = v1.xyzw;
  r1.xyz = cb4[1].xyz * v5.yyy;
  r1.xyz = v5.xxx * cb4[0].xyz + r1.xyz;
  r1.xyz = v5.zzz * cb4[2].xyz + r1.xyz;
  o5.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o6.xyz = v5.www * r0.xyz;
  r0.xyz = cb4[3].yyy * cb1[9].xyw;
  r0.xyz = cb4[3].xxx * cb1[8].xyw + r0.xyz;
  r0.xyz = cb4[3].zzz * cb1[10].xyw + r0.xyz;
  r0.xyz = cb4[3].www * cb1[11].xyw + r0.xyz;
  r0.xy = r0.xy / r0.zz;
  o7.zw = r0.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.xyz = -cb4[3].xyz + cb2[21].xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.x = cmp(r0.x < 2.9000001);
  o7.x = r0.x ? 1.000000 : 0;
  r0.xyz = -cb4[3].xyz + cb1[15].xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.y = cmp(v5.w == -1.000000);
  o7.y = r0.y ? -r0.x : r0.x;
  return;
}