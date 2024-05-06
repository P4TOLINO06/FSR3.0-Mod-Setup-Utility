// ---- FNV Hash 551ec5983db81bbf

// ---- Created with 3Dmigoto v1.3.16 on Fri Mar  8 21:28:29 2024
cbuffer cb12 : register(b12)
{
  float4 cb12[18];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[53];
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
  float4 v0 : POSITION0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float3 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = cb12[2].zxy * cb12[1].yzx;
  r0.xyz = cb12[2].yzx * cb12[1].zxy + -r0.xyz;
  r0.w = dot(v0.xy, v0.xy);
  r0.w = rsqrt(r0.w);
  r1.xy = v0.xy * r0.ww;
  r0.w = cmp(0.999899983 >= abs(v0.z));
  r1.xy = r0.ww ? r1.xy : 0;
  r0.xyz = r1.yyy * r0.xyz;
  r0.xyz = cb12[2].xyz * r1.xxx + r0.xyz;
  r0.w = 1 + -cb12[5].x;
  r1.xyzw = float4(1,-0,-0,-1) + v0.zxyz;
  r1.x = r1.x * r1.x;
  r1.yzw = cmp(abs(r1.yzw) < float3(9.99999975e-05,9.99999975e-05,9.99999975e-05));
  r0.w = -r1.x * r0.w + 1;
  r1.x = -r0.w * r0.w + 1;
  r2.xyz = cb12[1].xyz * r0.www;
  r0.w = min(1, abs(r1.x));
  r0.w = sqrt(r0.w);
  r3.xyz = r0.xyz * r0.www;
  r0.w = 1 + -v0.z;
  r4.xy = cb12[5].xy * r0.ww;
  r0.xyz = r4.yyy * r0.xyz;
  r4.xyz = cb12[1].xyz * r4.xxx;
  r0.w = cmp(0 >= v0.z);
  r0.xyz = r0.www ? r3.xyz : r0.xyz;
  r2.xyz = r0.www ? r2.xyz : r4.xyz;
  r0.xyz = r2.xyz + r0.xyz;
  r0.xyz = r0.xyz * cb12[4].yyy + cb12[0].xyz;
  r2.xyzw = cb1[9].xyzw * r0.yyyy;
  r2.xyzw = r0.xxxx * cb1[8].xyzw + r2.xyzw;
  r2.xyzw = r0.zzzz * cb1[10].xyzw + r2.xyzw;
  r2.xyzw = cb1[11].xyzw + r2.xyzw;
  o0.xyzw = r2.xyzw;
  o1.xyz = r0.xyz;
  r0.xyz = -cb1[15].xyz + r0.xyz;
  r3.x = r2.x + r2.w;
  r3.y = r2.w + -r2.y;
  o2.w = r2.w;
  o2.xy = float2(0.5,0.5) * r3.xy;
  r0.w = r1.z ? r1.y : 0;
  r0.w = r1.w ? r0.w : 0;
  r1.x = dot(r0.xyz, cb12[1].xyz);
  r1.yzw = -cb12[0].xyz + cb1[15].xyz;
  r2.x = dot(r1.yzw, r0.xyz);
  r2.y = cb12[5].x * cb12[5].x;
  r2.z = r2.y * r2.x;
  r2.w = dot(r1.yzw, cb12[1].xyz);
  r2.z = r1.x * r2.w + -r2.z;
  r3.x = dot(r0.xyz, r0.xyz);
  r3.y = r3.x * r2.y;
  r1.x = r1.x * r1.x + -r3.y;
  r3.y = dot(r1.yzw, r1.yzw);
  r2.y = r3.y * r2.y;
  r3.y = -cb12[4].y * cb12[4].y + r3.y;
  r3.y = r3.y * r3.x;
  r3.y = r2.x * r2.x + -r3.y;
  r3.y = sqrt(abs(r3.y));
  r3.y = -r3.y + -r2.x;
  r2.x = min(0, r2.x);
  r2.x = r2.x / r3.x;
  r1.yzw = -r0.xyz * r2.xxx + r1.yzw;
  r1.y = dot(r1.yzw, r1.yzw);
  r1.z = r3.y / r3.x;
  r1.w = sqrt(r3.x);
  r2.x = r2.w * r2.w + -r2.y;
  r2.y = cmp(r2.w < 0);
  r2.w = r2.x * r1.x;
  r2.x = cmp(r2.x < 0);
  r2.x = (int)r2.y | (int)r2.x;
  r2.y = r2.z * r2.z + -r2.w;
  r2.y = sqrt(abs(r2.y));
  r2.y = r2.z + -r2.y;
  r1.x = r2.y / -r1.x;
  r0.w = r0.w ? 0.99000001 : r1.x;
  r0.w = r2.x ? r0.w : 0;
  r2.x = saturate(max(r1.z, r0.w));
  r0.w = cmp(0 < r1.w);
  r1.xzw = r0.xyz / r1.www;
  r1.xzw = r0.www ? r1.xzw : 0;
  r2.y = 1;
  r2.xy = r0.ww ? r2.xy : 0;
  r3.xyz = r0.xyz * r2.xxx + cb1[15].xyz;
  r0.xyz = r0.xyz * r2.yyy + cb1[15].xyz;
  o3.xy = r2.xy;
  r2.xyz = r0.xyz + -r3.xyz;
  r2.x = dot(r2.xyz, r2.xyz);
  r2.x = sqrt(r2.x);
  r2.y = 0.00499999989 * r2.x;
  r2.x = max(1, r2.x);
  r3.xyz = r1.xzw * r2.yyy + r3.xyz;
  r4.xyz = -r1.xzw * r2.yyy + r0.xyz;
  r0.xyz = -cb1[15].xyz + r3.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.y = -cb3[50].x + r0.x;
  r0.y = max(0, r0.y);
  r0.x = r0.y / r0.x;
  r0.x = r0.z * r0.x;
  r0.z = cb3[52].z * r0.x;
  r0.x = cmp(0.00999999978 < abs(r0.x));
  r1.x = -1.44269502 * r0.z;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.z = r1.x / r0.z;
  r0.x = r0.x ? r0.z : 1;
  r0.z = cb3[51].w * r0.y;
  r0.y = -cb3[52].x + r0.y;
  r0.y = max(0, r0.y);
  r0.y = cb3[51].x * r0.y;
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.x = r0.z * r0.x;
  r0.x = min(1, r0.x);
  r0.x = 1.44269502 * r0.x;
  r0.x = exp2(r0.x);
  r0.x = min(1, r0.x);
  r0.xy = float2(1,1) + -r0.xy;
  r0.z = -r0.x * cb3[52].y + 1;
  r0.x = cb3[52].y * r0.x;
  r0.z = cb3[51].y * r0.z;
  r0.x = saturate(r0.z * r0.y + r0.x);
  r0.x = 1 + -r0.x;
  r0.y = cb12[14].x * cb12[3].w;
  r0.y = r0.y * r2.x;
  o2.z = r0.y * r0.x;
  r4.w = 1;
  r2.xyz = cb1[14].xyz;
  r2.w = cb1[7].z;
  r0.x = dot(r4.xyzw, r2.xyzw);
  r0.y = cb12[17].z / cb12[17].w;
  o3.z = -r0.x + -r0.y;
  r0.x = cb12[4].y * cb12[4].y;
  r0.x = r1.y / r0.x;
  r0.x = 1 + -r0.x;
  r0.x = r0.x * r0.x;
  r0.y = 1 + -cb12[15].w;
  r0.y = r0.y * r0.x + cb12[15].w;
  r0.x = r0.x / r0.y;
  r1.xyz = -cb12[15].xyz + cb12[3].xyz;
  r4.x = cmp(cb12[15].y < cb12[15].x);
  r4.y = 2.86520004 * cb12[15].y;
  r4.y = cmp(cb12[15].x < r4.y);
  r4.x = r4.y ? r4.x : 0;
  r4.y = 2.95910001 * cb12[15].z;
  r4.y = cmp(r4.y < cb12[15].y);
  r4.x = r4.y ? r4.x : 0;
  r4.xyz = r4.xxx ? cb12[15].yyy : cb12[15].xyz;
  r0.xyz = r0.xxx * r1.xyz + r4.xyz;
  o4.xyz = r0.www ? r0.xyz : 0;
  return;
}