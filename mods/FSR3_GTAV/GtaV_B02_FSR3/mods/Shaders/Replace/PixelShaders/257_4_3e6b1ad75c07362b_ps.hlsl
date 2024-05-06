// ---- FNV Hash 3e6b1ad75c07362b

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t0 : register(t0);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s0_s : register(s0);

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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(cb2[2].x == 1.000000);
  if (r0.x == 0) {
    r0.y = saturate(v2.z);
    r0.y = 1 + -r0.y;
    r0.z = 1 + -v2.w;
    r0.z = max(0.100000001, r0.z);
    r0.z = min(1, r0.z);
    r1.x = dot(v5.xyz, v4.xyz);
    r1.y = dot(v6.xyz, v4.xyz);
    r1.z = dot(v3.xyz, v4.xyz);
    r0.w = dot(r1.xyz, r1.xyz);
    r0.w = rsqrt(r0.w);
    r1.xyz = r1.xyz * r0.www;
    r0.z = max(r1.z, r0.z);
    r0.w = dot(v4.xyz, v4.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = v4.xyz * r0.www;
    r0.w = dot(v3.xyz, v3.xyz);
    r0.w = rsqrt(r0.w);
    r3.xyz = v3.xyz * r0.www;
    r0.w = dot(r2.xyz, r3.xyz);
    r1.z = 4 * abs(r0.w);
    r0.y = cb2[1].x * r0.y;
    r2.xy = abs(r0.ww) * float2(-24,-24) + float2(26,27);
    r2.x = saturate(r2.x);
    r0.y = r2.x * r0.y;
    r0.w = min(1, r1.z);
    r0.y = r0.y * r0.w;
    r1.zw = -r1.xy / r0.zz;
    r1.zw = cb12[2].xx * r1.zw;
    r1.zw = r1.zw * r0.yy;
    r0.zw = r1.xy / r0.zz;
    r0.zw = cb12[2].yy * r0.zw;
    r0.yz = r0.zw * r0.yy;
    r0.w = (int)r2.y;
    r1.x = cmp((int)r0.w == 0);
    r0.x = (int)r0.x | (int)r1.x;
    if (r0.x == 0) {
      r0.x = trunc(r2.y);
      r0.x = 1 / r0.x;
      r1.xy = ddx(v2.xy);
      r2.xy = ddy(v2.xy);
      r3.xyzw = t2.SampleGrad(s2_s, v2.xy, r1.xyxx, r2.xyxx).xyzw;
      r3.x = 0;
      r2.z = 9.99999997e-07 + r3.x;
      r3.xy = r0.yz;
      r2.w = 1;
      r3.z = 1;
      r3.w = r2.z;
      r4.x = r2.z;
      r4.y = 0;
      while (true) {
        r4.z = cmp((int)r4.y >= (int)r0.w);
        if (r4.z != 0) break;
        r4.z = cmp(r3.w < r2.w);
        if (r4.z != 0) {
          r4.z = r2.w + -r0.x;
          r3.xy = r1.zw * r0.xx + r3.xy;
          r5.xy = v2.xy + r3.xy;
          r5.xyzw = t2.SampleGrad(s2_s, r5.xy, r1.xyxx, r2.xyxx).xyzw;
          r3.z = r2.w;
          r4.x = r3.w;
          r2.w = r4.z;
          r3.w = r5.x;
        } else {
          r4.y = r0.w;
        }
        r4.y = (int)r4.y + 1;
      }
      r0.x = -r3.w + r2.w;
      r0.w = -r4.x + r3.z;
      r1.x = r0.w + -r0.x;
      r1.y = cmp(0 < r1.x);
      r0.x = r3.z * r0.x;
      r0.x = r2.w * r0.w + -r0.x;
      r0.x = r0.x / r1.x;
      r0.x = saturate(r1.y ? r0.x : r3.w);
    } else {
      r0.x = 0;
    }
    r0.x = 1 + -r0.x;
    r0.xy = r1.zw * r0.xx + r0.yz;
    r0.xy = v2.xy + r0.xy;
    r0.zw = r0.xy;
    r1.xy = r0.xy;
  } else {
    r1.xy = v2.xy;
    r0.xyzw = v2.xyxy;
  }
  r2.xyzw = t0.Sample(s0_s, r0.zw).xyzw;
  r3.xyzw = t3.Sample(s3_s, r0.xy).xyzw;
  r0.xy = r3.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r0.xy, r0.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, cb12[1].w);
  r0.xy = r1.ww * r0.xy;
  r3.xyz = v6.xyz * r0.yyy;
  r3.xyz = r0.xxx * v5.xyz + r3.xyz;
  r3.xyz = r1.zzz * v3.xyz + r3.xyz;
  r0.x = dot(r3.xyz, r3.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyw = r3.xyz * r0.xxx;
  r1.xyzw = t4.Sample(s4_s, r1.xy).xyzw;
  r1.xy = r1.xy * r1.xy;
  r0.y = dot(r1.xyz, cb12[1].xyz);
  r1.x = cb12[0].z * r0.y;
  r1.w = cb12[0].y * r1.w;
  r4.x = dot(v5.xyz, cb3[0].xyz);
  r4.y = dot(v6.xyz, cb3[0].xyz);
  r4.z = dot(v3.xyz, cb3[0].xyz);
  r4.w = 1 + -v2.z;
  r5.x = cb12[2].x * cb2[1].x;
  r4.xy = r5.xx * r4.xy;
  r4.xy = r4.xy * r4.ww;
  r4.xy = r4.xy / r4.zz;
  r5.xyzw = t2.Sample(s2_s, r0.zw).xyzw;
  r6.xyzw = r4.xyxy * float4(0.879999995,0.879999995,0.769999981,0.769999981) + r0.zwzw;
  r7.xyzw = t2.Sample(s2_s, r6.xy).xyzw;
  r4.z = r7.x + -r5.x;
  r4.z = -0.879999995 + r4.z;
  r6.xyzw = t2.Sample(s2_s, r6.zw).xyzw;
  r4.w = r6.x + -r5.x;
  r4.w = -0.769999981 + r4.w;
  r4.w = r4.w + r4.w;
  r6.xyzw = r4.xyxy * float4(0.660000026,0.660000026,0.550000012,0.550000012) + r0.zwzw;
  r7.xyzw = t2.Sample(s2_s, r6.xy).xyzw;
  r5.y = r7.x + -r5.x;
  r5.y = -0.660000026 + r5.y;
  r6.xyzw = t2.Sample(s2_s, r6.zw).xyzw;
  r5.z = r6.x + -r5.x;
  r5.z = -0.550000012 + r5.z;
  r6.xyzw = r4.xyxy * float4(0.439999998,0.439999998,0.330000013,0.330000013) + r0.zwzw;
  r7.xyzw = t2.Sample(s2_s, r6.xy).xyzw;
  r5.w = r7.x + -r5.x;
  r5.w = -0.439999998 + r5.w;
  r5.yzw = float3(4,6,8) * r5.yzw;
  r6.xyzw = t2.Sample(s2_s, r6.zw).xyzw;
  r6.x = r6.x + -r5.x;
  r6.x = -0.330000013 + r6.x;
  r6.x = 10 * r6.x;
  r0.zw = r4.xy * float2(0.219999999,0.219999999) + r0.zw;
  r7.xyzw = t2.Sample(s2_s, r0.zw).xyzw;
  r0.z = r7.x + -r5.x;
  r0.z = -0.219999999 + r0.z;
  r0.z = 12 * r0.z;
  r0.w = max(r4.z, r4.w);
  r0.w = max(r0.w, r5.y);
  r0.w = max(r0.w, r5.z);
  r0.w = max(r0.w, r5.w);
  r0.w = max(r0.w, r6.x);
  r0.z = saturate(max(r0.w, r0.z));
  o2.w = -r0.z * cb12[2].z + 1;
  r0.z = saturate(v3.z * 128 + -127);
  r0.w = v1.w * r2.w;
  r4.yz = cb2[12].zy * v1.xy;
  o0.w = cb2[12].x * r0.w;
  o1.xyz = r3.xyw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = -0.200000003 + cb12[2].w;
  r0.w = saturate(10 * r0.w);
  o1.w = r0.z * r0.w;
  r1.y = 0.001953125 * r1.w;
  r4.x = v1.x * cb2[12].z + cb3[45].w;
  r0.zw = float2(0.5,0.5) * r4.xz;
  o3.xy = sqrt(r0.zw);
  r0.x = r3.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r0.z = 1 + -cb2[13].z;
  r0.x = r0.x * r0.z;
  r0.x = r0.x * r4.y;
  r0.z = -r1.x * 0.5 + 1;
  r0.z = r0.x * r0.z;
  r0.x = cb12[2].w * r0.x;
  r0.z = r0.z * -0.5 + 1;
  o0.xyz = r2.xyz * r0.zzz;
  r0.y = saturate(r0.y * cb12[0].z + 0.400000006);
  r2.xy = float2(0.5,0.48828131) * r0.yy;
  r1.z = cb12[0].x;
  r2.z = 0.970000029;
  r0.yzw = r2.xyz + -r1.xyz;
  r0.yzw = max(float3(0,0,0), r0.yzw);
  r0.xyz = r0.yzw * r0.xxx + r1.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o3.zw = float2(0,1.00188398);
  return;
}