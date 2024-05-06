// ---- FNV Hash 99296c9dc8cb06fe

// ---- Created with 3Dmigoto v1.3.16 on Sat Mar  9 08:17:12 2024
cbuffer cb3 : register(b3)
{
  float4 cb3[50];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
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
  float2 v2 : TEXCOORD0,
  float3 v3 : NORMAL0,
  float4 v4 : TANGENT0,
  uint v5 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : COLOR0,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD4,
  out float3 o5 : TEXCOORD5,
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
// unknown dcl_: dcl_input v3.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyzw
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[9].xyzw * v0.yyyy;
  r0.xyzw = v0.xxxx * cb1[8].xyzw + r0.xyzw;
  r0.xyzw = v0.zzzz * cb1[10].xyzw + r0.xyzw;
  o0.xyzw = cb1[11].xyzw + r0.xyzw;
  r0.xyz = cb1[1].xyz * v0.yyy;
  r0.xyz = v0.xxx * cb1[0].xyz + r0.xyz;
  r0.xyz = v0.zzz * cb1[2].xyz + r0.xyz;
  r0.xyz = cb1[3].xyz + r0.xyz;
  r0.xyz = cb1[15].xyz + -r0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = 3.99999999e-06 * r0.x;
  r0.x = min(1, r0.x);
  r0.y = 1 + -r0.x;
  r0.xy = saturate(-cb2[13].zz + r0.xy);
  r0.z = -1 + cb3[49].w;
  r0.xy = r0.xy * r0.zz + float2(1,1);
  o1.xy = saturate(v1.xy * r0.xy);
  o1.zw = v1.zw;
  o2.xy = v2.xy;
  r0.x = dot(v3.xyz, v3.xyz);
  r0.x = cmp(r0.x < 0.100000001);
  r0.xyz = r0.xxx ? float3(0,0,1) : v3.xyz;
  r1.xyz = cb1[1].xyz * r0.yyy;
  r0.xyw = r0.xxx * cb1[0].xyz + r1.xyz;
  r0.xyz = r0.zzz * cb1[2].xyz + r0.xyw;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  o3.xyz = r0.xyz;
  r1.xyz = cb1[1].xyz * v4.yyy;
  r1.xyz = v4.xxx * cb1[0].xyz + r1.xyz;
  r1.xyz = v4.zzz * cb1[2].xyz + r1.xyz;
  o4.xyz = r1.xyz;
  r2.xyz = r1.zxy * r0.yzx;
  r0.xyz = r1.yzx * r0.zxy + -r2.xyz;
  o5.xyz = v4.www * r0.xyz;
  return;
}