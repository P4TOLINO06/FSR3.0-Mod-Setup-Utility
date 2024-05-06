// ---- FNV Hash d8c8590309575e52

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[5];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[5];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[50];
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
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float3 v6 : TEXCOORD5,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r1.xy = t4.Sample(s4_s, v1.xy).xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r2.xyz = v6.yxz * r1.yyy;
  r1.xyw = r1.xxx * v5.yxz + r2.xyz;
  r1.xyz = r1.zzz * v2.yxz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r3.xyz = t5.Sample(s5_s, v1.xy).xyz;
  r1.xy = r3.xy * r3.xy;
  r3.w = 1 + -r3.z;
  r2.w = v3.x * r1.x;
  r4.x = dot(v4.xyz, v4.xyz);
  r4.x = rsqrt(r4.x);
  r4.yzw = v4.xyz * r4.xxx;
  r5.x = cmp(0 < cb11[0].w);
  if (r5.x != 0) {
    r5.x = saturate(dot(r2.yxz, r4.yzw));
    r5.y = 0;
    r4.yzw = t6.Sample(s6_s, r5.xy).xyz;
  } else {
    r4.yzw = cb11[0].xyz;
  }
  r5.x = dot(r4.yzw, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r4.yzzw;
  r6.xyzw = cmp(r4.zywz < r6.xyzw);
  r5.y = r6.y ? r6.x : 0;
  r5.y = r6.z ? r5.y : 0;
  r5.y = r6.w ? r5.y : 0;
  r5.z = cmp(0.779999971 < r5.x);
  r5.y = r5.z ? r5.y : 0;
  r6.xyz = float3(0.796000004,0.796000004,0.796000004) * r4.yzw;
  r4.yzw = r5.yyy ? r6.xyz : r4.yzw;
  r0.xyz = r4.yzw * r0.xyz;
  r0.xyzw = v3.xxxw * r0.xyzw;
  r4.yz = cb2[12].zy * v3.xx;
  r4.w = saturate(cb3[49].w + cb2[13].z);
  r6.y = r4.z * r4.w;
  r2.w = v2.w * r2.w;
  r2.w = 0.600000024 * r2.w;
  r4.zw = -cb11[2].zz + float2(1,2);
  r5.y = v3.z * r4.z;
  r5.zw = v1.zw * r4.ww;
  r7.xyz = t3.Sample(s3_s, r5.zw).xyz;
  r4.w = t3.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r6.z = cmp(0.49000001 < r4.w);
  r4.w = cmp(r4.w < 0.50999999);
  r4.w = r4.w ? r6.z : 0;
  r6.z = saturate(cb11[2].y * 2.5 + -1.5);
  r6.z = r7.x * r6.z;
  r8.y = 1.29999995 * r6.z;
  r8.z = r7.y;
  r8.yz = r4.ww ? r8.yz : r7.yz;
  r4.w = t3.Sample(s3_s, r5.zw, int2(0, 0)).x;
  r6.z = t3.Sample(s3_s, r5.zw, int2(0, 0)).x;
  r6.w = t3.Sample(s3_s, r5.zw, int2(0, 0)).x;
  r5.z = t3.Sample(s3_s, r5.zw, int2(0, 0)).x;
  r4.w = 0.333333313 * r4.w;
  r5.w = 0.333333313 * r6.z;
  r6.z = 0.333333313 * r6.w;
  r5.z = 0.333333313 * r5.z;
  r5.x = -0.0170000009 + r5.x;
  r6.w = dot(cb11[3].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r5.x = cmp(r5.x < r6.w);
  r4.w = r5.x ? r4.w : -r4.w;
  r5.w = r5.x ? r5.w : -r5.w;
  r6.z = r5.x ? r6.z : -r6.z;
  r5.x = r5.x ? r5.z : -r5.z;
  r5.x = r5.x + -r6.z;
  r9.x = r5.x + r5.x;
  r4.w = r5.w + -r4.w;
  r9.y = r4.w + r4.w;
  r4.w = -r9.x * r9.x + 1;
  r4.w = -r9.y * r9.y + r4.w;
  r9.z = sqrt(r4.w);
  r5.xzw = max(float3(-1,-1,-1), r9.xyz);
  r5.xzw = min(float3(1,1,1), r5.xzw);
  r7.yzw = -cb3[0].xyz + float3(0,0,-1);
  r7.yzw = cb11[4].www * r7.yzw + cb3[0].xyz;
  r7.yzw = v4.xyz * r4.xxx + -r7.yzw;
  r4.x = dot(r7.yzw, r7.yzw);
  r4.x = rsqrt(r4.x);
  r9.xyz = r7.yzw * r4.xxx;
  r7.yzw = -r7.yzw * r4.xxx + float3(1,1,1);
  r7.yzw = sqrt(r7.yzw);
  r4.x = dot(r5.xzw, r7.yzw);
  r4.w = r7.x * r4.x;
  r5.x = cb11[2].z * cb5[3].z;
  r4.x = -r7.x * r4.x + r8.z;
  r8.x = r5.x * r4.x + r4.w;
  r4.xw = cb11[2].xx * r8.xy;
  r5.x = v3.z * r4.z + -1;
  r4.z = r4.z * r5.x + 1;
  r4.x = r4.x * r4.z;
  r5.xzw = cb11[3].xyz * cb11[2].yyy;
  r5.xzw = r5.xzw * float3(1.07558298,0.994183481,0.930233717) + -r0.xyz;
  r0.xyz = r4.xxx * r5.xzw + r0.xyz;
  r4.x = cb11[2].x * r5.y;
  r5.xyz = r8.zzz + -r0.xyz;
  r0.xyz = r4.xxx * r5.xyz + r0.xyz;
  r4.x = -r4.w * r4.z + 1;
  r3.x = r4.x * r2.w;
  r2.w = cb11[2].w * v3.x;
  r1.x = r2.w * r1.x;
  r1.x = 0.600000024 * r1.x;
  r3.yz = float2(20,0.8984375) * r1.yy;
  r1.y = dot(r2.yxz, r9.xyz);
  r1.y = saturate(9.99999994e-09 + r1.y);
  r4.xz = float2(0.400000006,9.99999994e-09) + r3.xy;
  r1.y = log2(r1.y);
  r1.y = r4.z * r1.y;
  r1.y = exp2(r1.y);
  r0.xyz = r1.xxx * r1.yyy + r0.xyz;
  r5.w = cb2[12].x * r0.w;
  r2.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r7.xyz = float3(256,256,256) * r2.xyz;
  r7.xyz = floor(r7.yxz);
  r2.xyz = r2.xyz * float3(256,256,256) + -r7.yxz;
  r2.xyz = float3(8,8,4) * r2.xyz;
  r2.xyz = floor(r2.xyz);
  r0.w = dot(r2.xyz, float3(4,32,1));
  o1.w = 0.00392156886 * r0.w;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r7.xyz;
  r6.x = cb2[12].z * v3.x + cb3[45].w;
  r1.xy = float2(0.5,0.5) * r6.xy;
  o3.xy = sqrt(r1.xy);
  r0.w = r1.z * r1.w + -0.349999994;
  r0.w = saturate(1.53846204 * r0.w);
  r0.w = cb5[3].z * r0.w;
  r1.x = -cb2[13].z + 1;
  r0.w = r1.x * r0.w;
  r0.w = r0.w * r4.y;
  r1.x = r3.x * -0.5 + 1;
  r1.x = r1.x * r0.w;
  r1.x = r1.x * -0.5 + 1;
  r5.xyz = r1.xxx * r0.xyz;
  r4.x = saturate(r4.x);
  r0.xy = r4.xx * float2(0.5,0.48828131) + -r3.xz;
  r0.xy = max(float2(0,0), r0.xy);
  r0.z = 0;
  r0.xyz = r0.xyz * r0.www + r3.xzw;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r5.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}