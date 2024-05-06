// ---- FNV Hash b8a841970af14e82

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:46:44 2023
cbuffer cb8 : register(b8)
{
  float4 cb8[7];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[59];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
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
  float3 v2 : NORMAL0,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  float4 v10 : TEXCOORD10,
  float4 v11 : TEXCOORD11,
  uint v12 : SV_InstanceID0,
  float4 v13 : TEXCOORD3,
  float4 v14 : TEXCOORD4,
  float4 v15 : TEXCOORD5,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD5,
  out float4 o5 : TEXCOORD6,
  out float4 o6 : TEXCOORD7,
  out float4 o7 : TEXCOORD8,
  out float4 o8 : TEXCOORD9,
  out float4 o9 : TEXCOORD10,
  out float4 o10 : TEXCOORD11,
  out float4 o11 : SV_Position0,
  out float4 o12 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v8.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v9.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v10.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v11.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v13.xy
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[3];
  float4 x1[3];
  float4 x2[3];
  float4 x3[3];
  x0[0].x = v9.x;
  x0[1].x = 0.5;
  x0[2].x = v9.y;
  x1[0].x = v9.z;
  x1[1].x = 0.5;
  x1[2].x = v9.w;
  x2[0].x = v9.x;
  x2[1].x = 0.5;
  x2[2].x = v9.y;
  x3[0].x = v9.z;
  x3[1].x = 0.5;
  x3[2].x = v9.w;
  r0.x = v4.w * v1.w;
  r0.x = v4.y * r0.x;
  r0.y = cmp(9.99999997e-07 >= v1.w);
  o0.w = r0.y ? 0 : r0.x;
  r0.xyz = v1.xyz * v1.xyz;
  o0.xyz = r0.xyz * v3.yyy + v1.xyz;
  r0.xy = (int2)v13.xy;
  r0.z = x0[r0.x+0].x;
  r1.xy = v11.yz + -v11.xw;
  o1.z = r0.z * r1.x + v11.x;
  r0.w = x1[r0.y+0].x;
  o1.w = r0.w * r1.y + v11.w;
  r1.xy = v10.yz + -v10.xw;
  o1.x = r0.z * r1.x + v10.x;
  o1.y = r0.w * r1.y + v10.w;
  r0.x = x2[r0.x+0].x;
  r0.y = x3[r0.y+0].x;
  o2.y = r0.y * r1.y + v10.w;
  o2.x = r0.x * r1.x + v10.x;
  o2.zw = float2(0,0);
  o3.x = saturate(v3.x);
  o3.y = v3.y;
  r1.xyz = v7.xyz + v0.xyz;
  r2.x = v6.w;
  r2.y = v7.w;
  r2.z = v8.w;
  r1.xyz = r2.xyz + r1.xyz;
  r2.xyz = v8.xyz + -r2.xyz;
  r0.xyz = r2.xyz * r0.zzz + r1.xyz;
  r3.xyz = -v7.xyz + v6.xyz;
  r0.xyz = r3.xyz * r0.www + r0.xyz;
  r2.xyz = r3.xyz + r2.xyz;
  r1.xyz = r2.xyz * float3(0.5,0.5,0.5) + r1.xyz;
  r2.xyz = float3(0.5,0.5,0.5) * r2.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = sqrt(r0.w);
  r0.w = 1 / r0.w;
  r2.xyz = -r1.xyz + r0.xyz;
  r0.xyz = r1.xyz + -r0.xyz;
  r1.xyz = r2.xyz * v4.www + r1.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.x = r0.x * r0.w;
  o7.x = cb8[4].y * r0.x;
  r0.xyz = cb1[15].xyz + -r1.xyz;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.xyz = r0.xyz * cb8[3].yyy + r1.xyz;
  r1.xyz = -cb1[15].xyz + r0.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r1.w = sqrt(r0.w);
  r0.w = rsqrt(r0.w);
  r2.xyz = r1.xyz * r0.www;
  r0.w = -cb3[50].x + r1.w;
  r0.w = max(0, r0.w);
  r1.x = r0.w / r1.w;
  r1.y = -cb8[6].y + r1.w;
  o7.y = saturate(r1.y / cb8[6].x);
  r1.x = r1.z * r1.x;
  r1.y = cb3[52].z * r1.x;
  r1.x = cmp(0.00999999978 < abs(r1.x));
  r1.z = -1.44269502 * r1.y;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.y = r1.z / r1.y;
  r1.x = r1.x ? r1.y : 1;
  r1.y = cb3[51].w * r0.w;
  r1.x = r1.y * r1.x;
  r1.x = min(1, r1.x);
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = min(1, r1.x);
  r1.x = 1 + -r1.x;
  r1.y = -r1.x * cb3[52].y + 1;
  r1.x = cb3[52].y * r1.x;
  r1.y = cb3[51].y * r1.y;
  r1.z = saturate(dot(r2.xyz, cb3[53].xyz));
  r1.w = saturate(dot(r2.xyz, cb3[54].xyz));
  r1.w = log2(r1.w);
  r1.w = cb3[54].w * r1.w;
  r1.w = exp2(r1.w);
  r1.z = log2(r1.z);
  r1.z = cb3[53].w * r1.z;
  r1.z = exp2(r1.z);
  r2.xyz = cb3[58].xyz + -cb3[56].xyz;
  r2.xyz = r1.www * r2.xyz + cb3[56].xyz;
  r3.xyz = cb3[55].xyz + -r2.xyz;
  r2.xyz = r1.zzz * r3.xyz + r2.xyz;
  r2.xyz = -cb3[57].xyz + r2.xyz;
  r1.z = -cb3[51].z * r0.w;
  r0.w = -cb3[52].x + r0.w;
  r0.w = max(0, r0.w);
  r0.w = cb3[51].x * r0.w;
  r0.w = 1.44269502 * r0.w;
  r0.w = exp2(r0.w);
  r0.w = 1 + -r0.w;
  o4.w = saturate(r1.y * r0.w + r1.x);
  r0.w = 1.44269502 * r1.z;
  r0.w = exp2(r0.w);
  r0.w = 1 + -r0.w;
  r1.xzw = r0.www * r2.xyz + cb3[57].xyz;
  r2.x = cb3[55].w + -r1.x;
  r2.y = cb3[56].w + -r1.z;
  r2.z = cb3[57].w + -r1.w;
  o4.xyz = r1.yyy * r2.xyz + r1.xzw;
  o5.xyzw = v4.xyzw;
  o6.xy = v5.xy;
  o6.zw = float2(0,0);
  pos.xyzw = float4(r0.xyz, 1);
  r1.xyzw = cb1[9].xyzw * r0.yyyy;
  r1.xyzw = r0.xxxx * cb1[8].xyzw + r1.xyzw;
  r0.xyzw = r0.zzzz * cb1[10].xyzw + r1.xyzw;
  r0.xyzw = cb1[11].xyzw + r0.xyzw;
  o7.w = r0.w;
  o7.z = 1;
  o8.xyzw = float4(0,0,0,0);
  o9.xyz = float3(0,0,0);
  o10.xyzw = float4(0,0,0,0);
  o11.xyzw = r0.xyzw;
  o12.x = dot(r0.xyzw, cb0[0].xyzw);
  o12.yzw = float3(0,0,0);
  return;
}