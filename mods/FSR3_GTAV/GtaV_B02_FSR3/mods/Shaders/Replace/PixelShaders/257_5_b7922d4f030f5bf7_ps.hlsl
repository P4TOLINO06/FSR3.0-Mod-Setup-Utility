// ---- FNV Hash b7922d4f030f5bf7

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t0 : register(t0);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[1];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[3];
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
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD4,
  float3 v5 : TEXCOORD5,
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
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb11[0].zw * v2.xy;
  r0.zw = float2(3.17000008,3.17000008) * r0.xy;
  r1.xyzw = t2.Sample(s2_s, r0.xy).xyzw;
  r0.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.xyzw = t2.Sample(s2_s, r0.zw).xyzw;
  r0.zw = r1.xy * float2(2,2) + float2(-1,-1);
  r0.zw = float2(0.5,0.5) * r0.zw;
  r0.xy = r0.xy * float2(0.5,0.5) + r0.zw;
  r0.yz = cb11[0].yy * r0.xy;
  r0.x = cb11[0].x * -r0.x;
  r1.xyzw = t3.Sample(s3_s, v2.xy).xyzw;
  r2.xyzw = t4.Sample(s4_s, v2.xy).xyzw;
  r0.yz = r0.yz * r2.ww + r1.xy;
  r0.yz = r0.yz * float2(2,2) + float2(-1,-1);
  r0.w = max(cb12[1].w, 0.00100000005);
  r1.xy = r0.yz * r0.ww;
  r0.y = dot(r0.yz, r0.yz);
  r0.y = 1 + -r0.y;
  r0.y = sqrt(abs(r0.y));
  r3.xyzw = v5.zxyz * r1.yyyy;
  r1.xyzw = r1.xxxx * v4.zxyz + r3.xyzw;
  r1.xyzw = r0.yyyy * v3.zxyz + r1.xyzw;
  r0.y = dot(r1.yzw, r1.yzw);
  r0.y = rsqrt(r0.y);
  r0.z = r1.x * r0.y + -0.349999994;
  r1.xyz = r1.yzw * r0.yyy;
  o1.xyz = r1.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.y = saturate(1.53846204 * r0.z);
  r0.y = cb5[3].z * r0.y;
  r0.z = -cb2[13].z + 1;
  r0.y = r0.y * r0.z;
  r1.yz = cb2[12].zy * v1.xy;
  r0.y = r1.y * r0.y;
  r0.x = r0.x * r2.w + 1;
  r2.xy = r2.xy * r2.xy;
  r0.z = cb12[0].y * r2.w;
  r3.y = 0.001953125 * r0.z;
  r0.z = dot(r2.xyz, cb12[1].xyz);
  r0.z = cb12[0].z * r0.z;
  r3.x = r0.z * r0.x;
  r0.z = saturate(r0.z * r0.x + 0.400000006);
  r2.xy = float2(0.5,0.48828131) * r0.zz;
  r0.z = r3.x * -0.5 + 1;
  r0.z = r0.y * r0.z;
  r0.y = cb12[2].x * r0.y;
  r0.z = r0.z * -0.5 + 1;
  r4.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r4.xyzw = r4.xyzw * r0.xxxx;
  o0.xyz = r4.xyz * r0.zzz;
  r0.x = v1.w * r4.w;
  o0.w = cb2[12].x * r0.x;
  r0.x = cb12[2].x + -0.200000003;
  r0.x = saturate(10 * r0.x);
  r0.z = saturate(v3.z * 128 + -127);
  o1.w = r0.z * r0.x;
  r2.z = 0.970000029;
  r3.z = cb12[0].x;
  r0.xzw = -r3.xyz + r2.xyz;
  r0.xzw = max(float3(0,0,0), r0.xzw);
  r0.xyz = r0.xzw * r0.yyy + r3.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o2.w = 1;
  r1.x = cb2[12].z * v1.x + cb3[45].w;
  r0.xy = float2(0.5,0.5) * r1.xz;
  o3.xy = sqrt(r0.xy);
  o3.zw = float2(0,1.00188398);
  return;
}