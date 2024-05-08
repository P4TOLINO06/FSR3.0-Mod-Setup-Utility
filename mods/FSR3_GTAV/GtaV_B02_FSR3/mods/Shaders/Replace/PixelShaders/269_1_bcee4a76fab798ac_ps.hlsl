// ---- FNV Hash bcee4a76fab798ac

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[9];
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
  float3 v4 : TEXCOORD3,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb11[0].xx * v1.xy;
  r0.zw = cb11[6].ww * v1.xy;
  r1.xyzw = t3.Sample(s3_s, v1.zw).xyzw;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.x = dot(v2.xyz, v2.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyz = v2.xyz * r0.xxx;
  r4.xyzw = t5.Sample(s5_s, r0.zw).xyzw;
  r4.xy = r4.xy * r4.xy;
  r0.y = dot(r4.xyz, cb11[6].xyz);
  r0.z = cb11[5].y * r0.y;
  r0.w = cb11[5].x * r4.w;
  r3.w = dot(v4.xyz, v4.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = v4.xyz * r3.www;
  r5.x = cmp(0 < cb11[1].x);
  if (r5.x != 0) {
    r4.x = saturate(dot(r3.xyz, r4.xyz));
    r4.y = 0;
    r4.xyz = t6.Sample(s6_s, r4.xy).xyz;
  } else {
    r4.xyz = cb11[0].yzw;
  }
  r5.x = dot(r4.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r4.xyyz;
  r6.xyzw = cmp(r4.yxzy < r6.xyzw);
  r5.y = r6.y ? r6.x : 0;
  r5.y = r6.z ? r5.y : 0;
  r5.y = r6.w ? r5.y : 0;
  r5.z = cmp(0.779999971 < r5.x);
  r5.y = r5.z ? r5.y : 0;
  r6.xyz = float3(0.796000004,0.796000004,0.796000004) * r4.xyz;
  r4.xyz = r5.yyy ? r6.xyz : r4.xyz;
  r4.xyz = r4.xyz * r2.xyz;
  r1.w = cb11[2].w * r1.w;
  r1.xyz = cb11[2].xyz * r1.xyz + -r4.xyz;
  r2.xyz = r1.www * r1.xyz + r4.xyz;
  r1.xyzw = v3.xxxw * r2.xyzw;
  r2.xy = cb2[12].zy * v3.xx;
  r2.z = saturate(cb3[49].w + cb2[13].z);
  r4.y = r2.y * r2.z;
  r0.z = v3.x * r0.z;
  r0.z = v2.w * r0.z;
  r2.yz = -cb11[3].zz + float2(1,2);
  r2.w = v3.z * r2.y;
  r5.yzw = v1.xyy * r2.zzz;
  r6.xyz = t4.Sample(s4_s, r5.yw).xyz;
  r2.z = t4.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r4.z = cmp(0.49000001 < r2.z);
  r2.z = cmp(r2.z < 0.50999999);
  r2.z = r2.z ? r4.z : 0;
  r4.z = saturate(cb11[3].y * 2.5 + -1.5);
  r6.w = r6.x * r4.z;
  r7.y = 1.29999995 * r6.w;
  r7.z = r6.y;
  r7.yz = r2.zz ? r7.yz : r6.yz;
  r6.y = t4.Sample(s4_s, r5.yw, int2(0, 0)).x;
  r6.z = t4.Sample(s4_s, r5.yw, int2(0, 0)).x;
  r6.w = t4.Sample(s4_s, r5.yw, int2(0, 0)).x;
  r7.w = t4.Sample(s4_s, r5.yw, int2(0, 0)).x;
  r6.yzw = float3(0.333333313,0.333333313,0.333333313) * r6.yzw;
  r7.w = 0.333333313 * r7.w;
  r5.x = -0.0170000009 + r5.x;
  r8.x = dot(cb11[4].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r5.x = cmp(r5.x < r8.x);
  r6.yzw = r5.xxx ? r6.yzw : -r6.yzw;
  r5.x = r5.x ? r7.w : -r7.w;
  r5.x = r5.x + -r6.w;
  r8.x = r5.x + r5.x;
  r5.x = r6.z + -r6.y;
  r8.y = r5.x + r5.x;
  r5.x = -r8.x * r8.x + 1;
  r5.x = -r8.y * r8.y + r5.x;
  r8.z = sqrt(r5.x);
  r6.yzw = max(float3(-1,-1,-1), r8.xyz);
  r6.yzw = min(float3(1,1,1), r6.yzw);
  r8.xyz = -cb3[0].xyz + float3(0,0,-1);
  r8.xyz = cb11[8].www * r8.xyz + cb3[0].xyz;
  r9.xyz = v4.xyz * r3.www + -r8.xyz;
  r3.w = dot(r9.xyz, r9.xyz);
  r3.w = rsqrt(r3.w);
  r10.xyz = r9.xyz * r3.www;
  r9.xyz = -r9.xyz * r3.www + float3(1,1,1);
  r9.xyz = sqrt(r9.xyz);
  r3.w = dot(r6.yzw, r9.xyz);
  r5.x = r6.x * r3.w;
  r6.y = cb11[3].z * cb5[3].z;
  r3.w = -r6.x * r3.w + r7.z;
  r7.x = r6.y * r3.w + r5.x;
  r6.xy = cb11[3].xx * r7.xy;
  r3.w = v3.z * r2.y + -1;
  r2.y = r2.y * r3.w + 1;
  r3.w = r6.x * r2.y;
  r6.xzw = cb11[4].xyz * cb11[3].yyy;
  r6.xzw = r6.xzw * float3(1.07558298,0.994183481,0.930233717) + -r1.xyz;
  r1.xyz = r3.www * r6.xzw + r1.xyz;
  r2.w = cb11[3].x * r2.w;
  r6.xzw = r7.zzz + -r1.xyz;
  r1.xyz = r2.www * r6.xzw + r1.xyz;
  r2.y = -r6.y * r2.y + 1;
  r6.x = r2.y * r0.z;
  r2.w = cmp(0 < cb11[7].y);
  if (r2.w != 0) {
    r2.w = cb11[7].y * cb11[3].w;
    r2.w = v3.x * r2.w;
    r0.y = r2.w * r0.y;
    r2.w = cmp(1.5 < abs(cb11[1].x));
    if (r2.w != 0) {
      r7.x = saturate(dot(r3.xyz, -r8.xyz));
      r7.y = 0;
      r7.xyz = t14.Sample(s14_s, r7.xy).xyz;
    } else {
      r7.xyz = cb11[8].xyz;
    }
    r7.xyz = r7.xyz * r0.yyy;
    r0.y = dot(r3.xyz, r10.xyz);
    r0.y = saturate(9.99999994e-09 + r0.y);
    r2.w = cb11[7].x * r4.w + 9.99999994e-09;
    r0.y = log2(r0.y);
    r0.y = r2.w * r0.y;
    r0.y = exp2(r0.y);
    r1.xyz = r7.xyz * r0.yyy + r1.xyz;
  }
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r7.w = cb2[12].x * r1.w;
  r3.xyz = r3.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.y = cmp(cb11[3].y < 1);
  r0.y = r0.y ? r2.z : 0;
  if (r0.y != 0) {
    r2.zw = cmp(r5.yw < float2(0.400000006,0.649999976));
    r0.y = r2.w ? r2.z : 0;
    r1.w = r0.y ? -1 : 1;
    r1.w = cb2[13].x * r1.w;
    r2.zw = -r1.ww * float2(4.8599999e-05,4.8599999e-05) + r5.yw;
    r2.zw = float2(7.69999981,7.69999981) * r2.zw;
    r8.xy = t4.Sample(s4_s, r2.zw).zw;
    r1.w = dot(r8.xy, r8.xy);
    r1.w = min(1, r1.w);
    r8.z = 1 + -r1.w;
    r1.w = dot(r8.xyz, r8.xyz);
    r1.w = sqrt(r1.w);
    r8.xyz = r3.xyz * r1.www;
    r9.xyz = float3(1.097,1.097,1.097) * r8.xyz;
    r5.xyz = r5.yzw * float3(2,2,2) + float3(-1,-1,-1);
    r5.xyz = float3(3.20000005,3.20000005,-2.4000001) * r5.xyz;
    r5.w = -r5.y;
    r5.xy = r0.yy ? r5.zz : r5.xw;
    r1.w = cb2[13].x * 0.0109350001;
    r2.z = cb2[13].x * 0.0109350001 + r5.y;
    r10.xyz = float3(12,24,22.2000008) * r5.xyx;
    r10.xz = floor(r10.xz);
    r10.xz = float2(12345.5596,12345.5596) * r10.xz;
    r10.xz = sin(r10.xz);
    r10.xz = float2(7658.75977,7658.75977) * r10.xz;
    r10.xz = frac(r10.xz);
    r5.z = r10.x + r2.z;
    r11.xyzw = float4(12,2,2,44.4000015) * r5.xzzy;
    r2.zw = floor(r11.xz);
    r2.z = dot(r2.zw, float2(35.2000008,2376.1001));
    r12.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.zzz;
    r12.xyz = frac(r12.xyz);
    r13.xyz = float3(19.1900005,19.1900005,19.1900005) + r12.yzx;
    r2.z = dot(r12.xyz, r13.xyz);
    r12.xyz = r12.xyz + r2.zzz;
    r2.zw = r12.xy + r12.yz;
    r2.zw = r2.zw * r12.zx;
    r2.zw = frac(r2.zw);
    r11.xyz = frac(r11.xyz);
    r10.xw = float2(-0.5,-0.5) + r2.zw;
    r2.z = sin(r10.y);
    r3.w = 0.5 + -abs(r10.x);
    r2.z = r3.w * r2.z;
    r2.z = r2.z * r10.w + r10.x;
    r2.w = cb2[13].x * 0.0145800002 + r2.w;
    r2.w = frac(r2.w);
    r3.w = 1.17647099 * r2.w;
    r3.w = min(1, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r2.w = -1 + r2.w;
    r2.w = -6.66666794 * r2.w;
    r2.w = min(1, r2.w);
    r4.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r4.w * r2.w;
    r2.w = r3.w * r2.w + -0.5;
    r10.xy = r2.ww * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r11.xyz = float3(-0.5,-0,-1) + r11.xyz;
    r2.w = 1 / r10.y;
    r2.w = saturate(r11.z * r2.w);
    r3.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r3.w * r2.w;
    r2.w = sqrt(r2.w);
    r3.w = r10.x + r10.x;
    r3.w = 1 / r3.w;
    r3.w = r11.y * r3.w;
    r3.w = min(1, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r3.w = sqrt(r3.w);
    r2.w = r3.w * r2.w;
    r3.w = 0.379999995 * r2.w;
    r4.w = r2.w * r2.w;
    r2.z = -r2.z * 0.699999988 + r11.x;
    r3.w = r4.w * 0.150000006 + -r3.w;
    r2.z = -r2.w * 0.379999995 + abs(r2.z);
    r2.w = 1 / r3.w;
    r2.z = saturate(r2.z * r2.w);
    r2.w = r2.z * -2 + 3;
    r2.z = r2.z * r2.z;
    r2.z = r2.w * r2.z;
    r2.w = r11.y + -r10.x;
    r2.w = 1 + r2.w;
    r2.w = saturate(0.980392218 * r2.w);
    r3.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r3.w * r2.w;
    r2.z = r2.z * r2.w;
    r1.w = r5.y * 1.85000002 + r1.w;
    r5.w = r1.w + r10.z;
    r5.xyz = float3(22.2000008,2,2) * r5.xww;
    r10.xy = floor(r5.xz);
    r1.w = dot(r10.xy, float2(35.2000008,2376.1001));
    r10.xyz = float3(0.103100002,0.113689996,0.137869999) * r1.www;
    r10.xyz = frac(r10.xyz);
    r11.xyz = float3(19.1900005,19.1900005,19.1900005) + r10.yzx;
    r1.w = dot(r10.xyz, r11.xyz);
    r10.xyz = r10.xyz + r1.www;
    r10.yw = r10.xy + r10.yz;
    r10.xy = r10.yw * r10.zx;
    r10.xy = frac(r10.xy);
    r5.xyz = frac(r5.xyz);
    r10.xz = float2(-0.5,-0.5) + r10.xy;
    r1.w = sin(r11.w);
    r2.w = 0.5 + -abs(r10.x);
    r1.w = r2.w * r1.w;
    r1.w = r1.w * r10.z + r10.x;
    r2.w = cb2[13].x * 0.0145800002 + r10.y;
    r2.w = frac(r2.w);
    r3.w = 1.17647099 * r2.w;
    r3.w = min(1, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r2.w = -1 + r2.w;
    r2.w = -6.66666794 * r2.w;
    r2.w = min(1, r2.w);
    r4.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r4.w * r2.w;
    r2.w = r3.w * r2.w + -0.5;
    r10.xy = r2.ww * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r5.xyz = float3(-0.5,-0,-1) + r5.xyz;
    r2.w = 1 / r10.y;
    r2.w = saturate(r5.z * r2.w);
    r3.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r3.w * r2.w;
    r2.w = sqrt(r2.w);
    r3.w = r10.x + r10.x;
    r3.w = 1 / r3.w;
    r3.w = r5.y * r3.w;
    r3.w = min(1, r3.w);
    r4.w = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.w * r3.w;
    r3.w = sqrt(r3.w);
    r2.w = r3.w * r2.w;
    r3.w = 0.379999995 * r2.w;
    r4.w = r2.w * r2.w;
    r1.w = -r1.w * 0.699999988 + r5.x;
    r3.w = r4.w * 0.150000006 + -r3.w;
    r1.w = -r2.w * 0.379999995 + abs(r1.w);
    r2.w = 1 / r3.w;
    r1.w = saturate(r2.w * r1.w);
    r2.w = r1.w * -2 + 3;
    r1.w = r1.w * r1.w;
    r1.w = r2.w * r1.w;
    r2.w = r5.y + -r10.x;
    r2.w = 1 + r2.w;
    r2.w = saturate(0.980392218 * r2.w);
    r3.w = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r3.w * r2.w;
    r1.w = r2.w * r1.w;
    r1.w = max(r2.z, r1.w);
    r1.w = min(1, r1.w);
    r5.xyz = -r8.xyz * float3(1.097,1.097,1.097) + r3.xyz;
    r5.xyz = r1.www * r5.xyz + r9.xyz;
    r0.y = r0.y ? 0.003900 : 0;
    r0.y = r1.w * r0.y + 1;
    r8.xyz = -r5.xyz + r3.xyz;
    r3.xyz = r4.zzz * r8.xyz + r5.xyz;
  } else {
    r0.y = 1;
  }
  r5.xyz = float3(256,256,256) * r3.xyz;
  r5.xyz = floor(r5.xyz);
  r3.xyz = r3.xyz * float3(256,256,256) + -r5.xyz;
  r3.xyz = float3(8,8,4) * r3.xyz;
  r3.xyz = floor(r3.xyz);
  r1.w = dot(r3.xyz, float3(32,4,1));
  o1.w = 0.00392156886 * r1.w;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r5.xyz;
  r6.y = 0.001953125 * r0.w;
  r4.x = cb2[12].z * v3.x + cb3[45].w;
  r2.zw = float2(0.5,0.5) * r4.xy;
  o3.xy = sqrt(r2.zw);
  r0.x = v2.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r0.w = -cb2[13].z + 1;
  r0.x = r0.x * r0.w;
  r0.x = r0.x * r2.x;
  r0.w = r6.x * -0.5 + 1;
  r0.w = r0.x * r0.w;
  r0.w = r0.w * -0.5 + 1;
  r7.xyz = r1.xyz * r0.www;
  r0.z = saturate(r2.y * r0.z + 0.400000006);
  r6.z = cb11[4].w * r0.y;
  r0.yz = r0.zz * float2(0.5,0.48828131) + -r6.xy;
  r1.xy = max(float2(0,0), r0.yz);
  r1.z = 0;
  r0.xyz = r1.xyz * r0.xxx + r6.xyz;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r7.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}