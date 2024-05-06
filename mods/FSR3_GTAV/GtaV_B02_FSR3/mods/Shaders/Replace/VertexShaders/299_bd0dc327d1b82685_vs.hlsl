// ---- FNV Hash bd0dc327d1b82685

// ---- Created with 3Dmigoto v1.3.16 on Sat Mar  9 08:17:12 2024
cbuffer cb2 : register(b2)
{
  float4 cb2[21];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[16];
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = cb12[2].zxy * cb12[1].yzx;
  r0.xyz = cb12[2].yzx * cb12[1].zxy + -r0.xyz;
  r0.w = cmp(0.999899983 >= abs(v0.z));
  r1.x = dot(v0.xy, v0.xy);
  r1.x = rsqrt(r1.x);
  r1.xy = v0.xy * r1.xx;
  r1.xy = r0.ww ? r1.xy : 0;
  r0.xyz = r1.yyy * r0.xyz;
  r0.xyz = cb12[2].xyz * r1.xxx + r0.xyz;
  r0.w = cmp(0 >= v0.z);
  r1.x = 1 + v0.z;
  r1.x = r1.x * r1.x;
  r1.y = -cb12[5].x + 1;
  r1.x = -r1.x * r1.y + 1;
  r1.y = -r1.x * r1.x + 1;
  r1.y = min(1, abs(r1.y));
  r1.y = sqrt(r1.y);
  r1.xzw = cb12[1].xyz * r1.xxx;
  r2.xyz = r1.yyy * r0.xyz;
  r1.y = 1 + -v0.z;
  r3.xy = cb12[5].xy * r1.yy;
  r3.xzw = cb12[1].xyz * r3.xxx;
  r0.xyz = r3.yyy * r0.xyz;
  r0.xyz = r0.www ? r2.xyz : r0.xyz;
  r1.xyz = r0.www ? r1.xzw : r3.xzw;
  r0.xyz = r1.xyz + r0.xyz;
  r0.xyz = r0.xyz * cb12[4].yyy + cb12[0].xyz;
  r1.xyz = -cb1[15].xyz + r0.xyz;
  r2.y = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r2.y);
  r1.w = cmp(0 < r0.w);
  if (r1.w != 0) {
    r3.xyz = -cb12[0].xyz + cb1[15].xyz;
    r1.w = cb12[5].x * cb12[5].x;
    r2.z = dot(r3.xyz, r1.xyz);
    r2.w = dot(r3.xyz, r3.xyz);
    r3.w = dot(r3.xyz, cb12[1].xyz);
    r4.x = dot(r1.xyz, cb12[1].xyz);
    r4.y = r4.x * r4.x;
    r4.z = -r1.w * r2.y + r4.y;
    r4.w = r2.z * r1.w;
    r5.xy = r4.xx * r3.ww + -r4.ww;
    r4.w = r2.w * r1.w;
    r3.w = r3.w * r3.w + -r4.w;
    r3.w = r4.z * r3.w;
    r3.w = r5.y * r5.y + -r3.w;
    r2.x = -r4.z;
    r6.x = sqrt(abs(r3.w));
    r3.w = cb12[4].y * cb12[4].y;
    r2.w = -cb12[4].y * cb12[4].y + r2.w;
    r2.w = r2.w * r2.y;
    r2.w = r2.z * r2.z + -r2.w;
    r2.w = sqrt(abs(r2.w));
    r5.zw = -r2.zz;
    r6.zw = float2(1,-1) * r2.ww;
    r6.y = -r6.x;
    r5.xyzw = r6.xyzw + r5.xyzw;
    r5.xyzw = r5.xyzw / r2.xxyy;
    r2.x = max(r5.z, r5.w);
    r6.xyz = r1.xyz * r5.xxx + cb1[15].xyz;
    r7.xyz = r1.xyz * r5.yyy + cb1[15].xyz;
    r6.xyz = -cb12[0].xyz + r6.xyz;
    r6.x = dot(r6.xyz, cb12[1].xyz);
    r7.xyz = -cb12[0].xyz + r7.xyz;
    r6.y = dot(r7.xyz, cb12[1].xyz);
    r4.zw = cmp(r6.xy >= float2(0,0));
    r4.zw = r4.zw ? float2(1,1) : 0;
    r4.zw = r5.xy * r4.zw;
    r2.w = max(r4.z, r4.w);
    r4.y = r4.y / r2.y;
    r1.w = cmp(r4.y >= r1.w);
    r4.x = cmp(0 < r4.x);
    r1.w = r1.w ? r4.x : 0;
    r1.w = r1.w ? 1000000.000000 : 0;
    r1.w = r2.w + r1.w;
    r1.w = min(r1.w, r2.x);
    r4.y = max(1.00999999, r1.w);
    r1.w = min(0, r2.z);
    r1.w = r1.w / r2.y;
    r2.xyz = -r1.xyz * r1.www + r3.xyz;
    r1.w = dot(r2.xyz, r2.xyz);
    r1.w = r1.w / r3.w;
    r1.w = 1 + -r1.w;
    r1.w = r1.w * r1.w;
    r2.x = -cb12[15].w + 1;
    r2.x = r2.x * r1.w + cb12[15].w;
    r1.w = r1.w / r2.x;
    r2.xyz = -cb12[15].xyz + cb12[3].xyz;
    r2.w = cmp(cb12[15].y < cb12[15].x);
    r3.xy = cb12[15].yz * float2(2.86520004,2.95910001);
    r3.x = cmp(cb12[15].x < r3.x);
    r2.w = r2.w ? r3.x : 0;
    r3.x = cmp(r3.y < cb12[15].y);
    r2.w = r2.w ? r3.x : 0;
    r3.xyz = r2.www ? cb12[15].yyy : cb12[15].xyz;
    o4.xyz = r1.www * r2.xyz + r3.xyz;
    r2.xyz = r1.xyz / r0.www;
    r4.x = 1;
  } else {
    o4.xyz = float3(0,0,0);
    r2.xyz = float3(0,0,0);
    r4.xy = float2(0,0);
  }
  r3.xyz = r1.xyz * r4.xxx + cb1[15].xyz;
  r1.xyz = r1.xyz * r4.yyy + cb1[15].xyz;
  r1.xyz = r1.xyz + -r3.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r1.x = 0.00499999989 * r0.w;
  r1.xyz = r2.xyz * r1.xxx + r3.xyz;
  r1.w = cb12[14].x * cb12[3].w;
  r0.w = max(1, r0.w);
  r0.w = r1.w * r0.w;
  r1.xyz = -cb1[15].xyz + r1.xyz;
  r1.x = dot(r1.xyz, r1.xyz);
  r1.x = sqrt(r1.x);
  r1.y = -cb3[50].x + r1.x;
  r1.y = max(0, r1.y);
  r1.x = r1.y / r1.x;
  r1.x = r1.z * r1.x;
  r1.z = cb3[52].z * r1.x;
  r1.x = cmp(0.00999999978 < abs(r1.x));
  r1.w = -1.44269502 * r1.z;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r1.z = r1.w / r1.z;
  r1.x = r1.x ? r1.z : 1;
  r1.z = cb3[51].w * r1.y;
  r1.x = r1.z * r1.x;
  r1.x = min(1, r1.x);
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = min(1, r1.x);
  r1.x = 1 + -r1.x;
  r1.z = cb3[52].y * r1.x;
  r2.x = -r1.x * cb3[52].y + 1;
  r1.x = -cb3[52].x + r1.y;
  r2.y = max(0, r1.x);
  r1.xy = cb3[51].yx * r2.xy;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r1.x = saturate(r1.x * r1.y + r1.z);
  r1.x = 1 + -r1.x;
  r0.w = r1.x * r0.w;
  r1.xyzw = cb1[9].xyzw * r0.yyyy;
  r1.xyzw = r0.xxxx * cb1[8].xyzw + r1.xyzw;
  r1.xyzw = r0.zzzz * cb1[10].xyzw + r1.xyzw;
  r1.xyzw = cb1[11].xyzw + r1.xyzw;
  r2.x = r1.x + r1.w;
  r2.y = r1.w + -r1.y;
  o2.xy = float2(0.5,0.5) * r2.xy;
  r2.xyz = cb2[20].xyz + -cb12[0].xyz;
  r2.x = dot(r2.xyz, r2.xyz);
  r2.x = sqrt(r2.x);
  r2.x = cmp(r2.x < 1.89999998);
  r2.y = 0.00999999978 * r0.w;
  o2.z = r2.x ? r2.y : r0.w;
  o0.xyzw = r1.xyzw;
  o2.w = r1.w;
  o1.xyz = r0.xyz;
  r4.z = 0;
  o3.xyz = r4.xyz;
  return;
}