// ---- FNV Hash 7998e270b32b6db3

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:07:12 2023
Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t0 : register(t0);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s0_s : register(s0);

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

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
  row_major float4x4 gWorldViewProjUnjittered;
  row_major float4x4 gWorldViewProjUnjitteredPrev;
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r1.xy = t3.Sample(s3_s, v1.xy).xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r2.xyz = v6.xyz * r1.yyy;
  r1.xyw = r1.xxx * v5.xyz + r2.xyz;
  r1.xyz = r1.zzz * v2.xyz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r3.xyz = t4.Sample(s4_s, v1.xy).xyz;
  r4.yz = r3.xy * r3.xy;
  r4.w = 1 + -r3.z;
  r1.x = dot(v4.xyz, v4.xyz);
  r1.x = rsqrt(r1.x);
  r3.xyz = v4.xyz * r1.xxx;
  r1.y = cmp(0 < cb12[0].w);
  if (r1.y != 0) {
    r3.x = saturate(dot(r2.xyz, r3.xyz));
    r3.y = 0;
    r3.xyz = t5.Sample(s5_s, r3.xy).xyz;
  } else {
    r3.xyz = cb12[0].xyz;
  }
  r0.xyz = r3.xyz * r0.xyz;
  r0.xyzw = v3.xxxw * r0.xyzw;
  r3.xy = cb2[12].zy * v3.xx;
  r1.y = saturate(cb3[49].w + cb2[13].z);
  r5.y = r3.y * r1.y;
  r1.y = v3.x * r4.y;
  r3.yz = -cb12[2].zz + float2(1,2);
  r2.w = v3.z * r3.y;
  r6.xz = v1.wz * r3.zz;
  r7.xyz = t2.Sample(s2_s, r6.zx).xyz;
  r3.z = t2.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r3.w = cmp(0.49000001 < r3.z);
  r3.z = cmp(r3.z < 0.50999999);
  r3.z = r3.z ? r3.w : 0;
  r5.zw = float2(1.29999995,1) * r7.xy;
  r8.yz = r3.zz ? r5.zw : r7.yz;
  r3.z = t2.Sample(s2_s, r0.zw, int2(0, 0)).x;
  r3.w = t2.Sample(s2_s, r0.zw, int2(0, 0)).x;
  r5.z = t2.Sample(s2_s, r0.zw, int2(0, 0)).x;
  r5.w = t2.Sample(s2_s, r0.zw, int2(0, 0)).x;
  r3.zw = float2(0.333333313,0.333333313) * r3.zw;
  r5.zw = float2(0.333333313,0.333333313) * r5.zw;
  r7.y = dot(cb12[0].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r7.y = -0.0170000009 + r7.y;
  r7.z = dot(cb12[3].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r7.y = cmp(r7.y < r7.z);
  r3.zw = r7.yy ? r3.zw : -r3.zw;
  r5.zw = r7.yy ? r5.zw : -r5.zw;
  r5.z = r5.w + -r5.z;
  r9.x = r5.z + r5.z;
  r3.z = r3.w + -r3.z;
  r9.y = r3.z + r3.z;
  r3.z = -r9.x * r9.x + 1;
  r3.z = -r9.y * r9.y + r3.z;
  r9.z = sqrt(r3.z);
  r7.yzw = max(float3(-1,-1,-1), r9.xyz);
  r7.yzw = min(float3(1,1,1), r7.yzw);
  r9.xyz = -cb3[0].xyz + float3(0,0,-1);
  r9.xyz = cb12[4].www * r9.xyz + cb3[0].xyz;
  r9.xyz = v4.xyz * r1.xxx + -r9.xyz;
  r1.x = dot(r9.xyz, r9.xyz);
  r1.x = rsqrt(r1.x);
  r10.xyz = r9.xyz * r1.xxx;
  r9.xyz = -r9.xyz * r1.xxx + float3(1,1,1);
  r9.xyz = sqrt(r9.xyz);
  r1.x = dot(r7.yzw, r9.xyz);
  r3.z = r7.x * r1.x;
  r3.w = cb12[2].z * cb5[3].z;
  r1.x = -r7.x * r1.x + r8.z;
  r8.x = r3.w * r1.x + r3.z;
  r3.zw = cb12[2].xx * r8.xy;
  r1.x = v3.z * r3.y + -1;
  r1.x = r3.y * r1.x + 1;
  r3.y = r3.z * r1.x;
  r7.yzw = cb12[3].xyz * cb12[2].yyy;
  r7.yzw = r7.yzw * float3(1.07255995,0.994416118,0.933024287) + -r0.xyz;
  r5.zw = cb2[13].ww + float2(-1.25,-1.35000002);
  r3.z = r5.z * r5.w;
  r3.z = saturate(-400 * r3.z);
  r5.z = cmp(0 < r3.z);
  r5.w = r7.x * r7.x;
  r5.w = r5.w * r5.w;
  r5.w = r5.w * r5.w;
  r8.x = saturate(cb12[2].x * 110);
  r5.w = r8.x * r5.w;
  r3.z = r5.w * r3.z;
  r3.z = r3.z * r7.x;
  r5.w = 1.10000002 * r3.z;
  r3.z = -r3.z * 1.10000002 + 1;
  r8.xyw = r0.xyz * r3.zzz + r5.www;
  r0.xyz = r5.zzz ? r8.xyw : r0.xyz;
  r0.xyz = r3.yyy * r7.yzw + r0.xyz;
  r2.w = cb12[2].x * r2.w;
  r7.xyz = r8.zzz + -r0.xyz;
  r0.xyz = r2.www * r7.xyz + r0.xyz;
  r1.x = -r3.w * r1.x + 1;
  r4.x = r1.x * r1.y;
  r2.w = cb12[2].w * v3.x;
  r2.w = r2.w * r4.y;
  r2.w = 1.5 * r2.w;
  r3.y = dot(r2.xyz, r10.xyz);
  r3.y = saturate(9.99999994e-09 + r3.y);
  r3.zw = r4.zx * float2(7,-0.5) + float2(9.99999994e-09,1);
  r3.y = log2(r3.y);
  r3.y = r3.z * r3.y;
  r3.y = exp2(r3.y);
  r0.xyz = r2.www * r3.yyy + r0.xyz;
  o0.w = cb2[12].x * r0.w;
  r2.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = cmp(cb12[2].y < 1);
  if (r0.w != 0) {
    r0.w = saturate(cb12[2].y * 2.5 + -1.5);
    r0.w = 1 + -r0.w;
    r3.yz = cb2[13].xx * float2(0.000140799995,0.000154880006);
    r6.yw = r6.xx * float2(-2.25,-3) + r3.yz;
    r7.xyzw = float4(-45,5,-60,5) * r6.zyzw;
    r8.xyzw = floor(r7.xyzw);
    r3.yz = float2(17.6000004,35.2000008) + r8.yw;
    r3.yz = r3.yz * float2(2376.1001,2376.1001) + r8.xz;
    r8.xyz = float3(0.129897997,0.782329977,0.377189994) * r3.yyy;
    r8.xyz = frac(r8.xyz);
    r9.xyz = float3(19.1900005,19.1900005,19.1900005) + r8.yzx;
    r3.y = dot(r8.xyz, r9.xyz);
    r8.xyz = r8.xyz + r3.yyy;
    r5.zw = r8.yx + r8.zy;
    r5.zw = r5.zw * r8.xz;
    r5.zw = frac(r5.zw);
    r7.xyzw = frac(r7.xyzw);
    r7.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r7.xyzw;
    r7.yw = float2(4,4) * r7.yw;
    r3.y = -0.5 + r5.w;
    r8.x = r3.y * 0.600000024 + r7.x;
    r8.zw = float2(6.28318501,0.150000006) * r5.zw;
    r3.y = cb2[13].x * 0.00335999997 + r8.z;
    r3.y = sin(r3.y);
    r3.y = r3.y * 0.5 + 0.5;
    r3.y = frac(r3.y);
    r3.y = -0.5 + r3.y;
    r8.y = r3.y * -2 + r7.y;
    r3.y = dot(r8.xy, r8.xy);
    r3.y = sqrt(r3.y);
    r3.y = -r5.w * 0.150000006 + r3.y;
    r4.y = 1 / -r8.w;
    r3.y = saturate(r4.y * r3.y);
    r4.y = r3.y * -2 + 3;
    r3.y = r3.y * r3.y;
    r3.y = r4.y * r3.y;
    r9.xyz = float3(0.129897997,0.782329977,0.377189994) * r3.zzz;
    r9.xyz = frac(r9.xyz);
    r10.xyz = float3(19.1900005,19.1900005,19.1900005) + r9.yzx;
    r3.z = dot(r9.xyz, r10.xyz);
    r9.xyz = r9.xyz + r3.zzz;
    r5.zw = r9.yx + r9.zy;
    r5.zw = r5.zw * r9.xz;
    r5.zw = frac(r5.zw);
    r3.z = -0.5 + r5.w;
    r7.x = r3.z * 0.600000024 + r7.z;
    r8.zw = float2(6.28318501,0.200000003) * r5.zw;
    r3.z = cb2[13].x * 0.00369599997 + r8.z;
    r3.z = sin(r3.z);
    r3.z = r3.z * 0.5 + 0.5;
    r3.z = frac(r3.z);
    r3.z = -0.5 + r3.z;
    r7.y = r3.z * -2 + r7.w;
    r3.z = dot(r7.xy, r7.xy);
    r3.z = sqrt(r3.z);
    r3.z = -r5.w * 0.200000003 + r3.z;
    r4.y = 1 / -r8.w;
    r3.z = saturate(r4.y * r3.z);
    r4.y = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r4.y * r3.z;
    r5.zw = r7.xy * r3.zz;
    r3.yz = r8.xy * r3.yy + r5.zw;
    r5.zw = cb2[13].xx * float2(0.000168960003,0.00018304);
    r6.xy = r6.xx * float2(-4.5,-6) + r5.zw;
    r6.xyzw = float4(-90,5,-120,5) * r6.zxzy;
    r7.xyzw = floor(r6.xyzw);
    r5.zw = float2(70.4000015,281.600006) + r7.yw;
    r5.zw = r5.zw * float2(2376.1001,2376.1001) + r7.xz;
    r7.xyz = float3(0.129897997,0.782329977,0.377189994) * r5.zzz;
    r7.xyz = frac(r7.xyz);
    r8.xyz = float3(19.1900005,19.1900005,19.1900005) + r7.yzx;
    r4.y = dot(r7.xyz, r8.xyz);
    r7.xyz = r7.xyz + r4.yyy;
    r7.yw = r7.yx + r7.zy;
    r7.xy = r7.yw * r7.xz;
    r7.xy = frac(r7.xy);
    r6.xyzw = frac(r6.xyzw);
    r6.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r6.xyzw;
    r6.yw = float2(4,4) * r6.yw;
    r4.y = -0.5 + r7.y;
    r8.x = r4.y * 0.600000024 + r6.x;
    r7.xz = float2(6.28318501,0.300000012) * r7.xy;
    r4.y = cb2[13].x * 0.00403199997 + r7.x;
    r4.y = sin(r4.y);
    r4.y = r4.y * 0.5 + 0.5;
    r4.y = frac(r4.y);
    r4.y = -0.5 + r4.y;
    r8.y = r4.y * -2 + r6.y;
    r4.y = dot(r8.xy, r8.xy);
    r4.y = sqrt(r4.y);
    r4.y = -r7.y * 0.300000012 + r4.y;
    r5.z = 1 / -r7.z;
    r4.y = saturate(r5.z * r4.y);
    r5.z = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r5.z * r4.y;
    r3.yz = r8.xy * r4.yy + r3.yz;
    r7.xyz = float3(0.129897997,0.782329977,0.377189994) * r5.www;
    r7.xyz = frac(r7.xyz);
    r8.xyz = float3(19.1900005,19.1900005,19.1900005) + r7.yzx;
    r4.y = dot(r7.xyz, r8.xyz);
    r7.xyz = r7.xyz + r4.yyy;
    r5.zw = r7.yx + r7.zy;
    r5.zw = r5.zw * r7.xz;
    r5.zw = frac(r5.zw);
    r4.y = -0.5 + r5.w;
    r6.x = r4.y * 0.600000024 + r6.z;
    r7.xy = float2(6.28318501,0.400000006) * r5.zw;
    r4.y = cb2[13].x * 0.0043680002 + r7.x;
    r4.y = sin(r4.y);
    r4.y = r4.y * 0.5 + 0.5;
    r4.y = frac(r4.y);
    r4.y = -0.5 + r4.y;
    r6.y = r4.y * -2 + r6.w;
    r4.y = dot(r6.xy, r6.xy);
    r4.y = sqrt(r4.y);
    r4.y = -r5.w * 0.400000006 + r4.y;
    r5.z = 1 / -r7.y;
    r4.y = saturate(r5.z * r4.y);
    r5.z = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r5.z * r4.y;
    r3.yz = r6.xy * r4.yy + r3.yz;
    r4.y = cmp(1.000000 == cb12[0].x);
    r4.y = r4.y ? 4 : 8;
    r5.z = cb1[15].z + -790;
    r5.z = saturate(0.00714285718 * r5.z);
    r5.z = 1 + -r5.z;
    r4.y = r5.z * r4.y;
    r3.yz = r4.yy * r3.yz;
    r2.xy = r3.yz * r0.ww + r2.xy;
  }
  r5.x = cb2[12].z * v3.x + cb3[45].w;
  r3.yz = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r3.yz);
  r0.w = r1.z * r1.w + -0.349999994;
  r0.w = saturate(1.53846204 * r0.w);
  r0.w = cb5[3].z * r0.w;
  r1.z = -cb2[13].z + 1;
  r0.w = r1.z * r0.w;
  r0.w = r0.w * r3.x;
  r1.z = r3.w * r0.w;
  r1.z = r1.z * -0.5 + 1;
  o0.xyz = r1.zzz * r0.xyz;
  r0.x = saturate(r1.x * r1.y + 0.400000006);
  r0.xy = r0.xx * float2(0.5,0.48828131) + -r4.xz;
  r0.xy = max(float2(0,0), r0.xy);
  r0.z = 0;
  r0.xyz = r0.xyz * r0.www + r4.xzw;
  o2.xy = sqrt(r0.xy);
  r2.w = 0;
  o1.xyzw = r2.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}