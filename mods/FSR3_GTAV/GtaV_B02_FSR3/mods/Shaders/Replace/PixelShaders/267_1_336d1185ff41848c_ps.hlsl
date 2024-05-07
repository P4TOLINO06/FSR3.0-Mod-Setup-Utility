// ---- FNV Hash 336d1185ff41848c

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[7];
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r1.x = dot(v2.xyz, v2.xyz);
  r1.x = rsqrt(r1.x);
  r1.yzw = v2.xyz * r1.xxx;
  r2.xyzw = t4.Sample(s4_s, v1.xy).xyzw;
  r3.x = cmp(5 < cb11[4].x);
  r4.x = 0.00157977897 * v2.w;
  r4.y = cb11[4].y * 633;
  r5.x = v2.w;
  r5.y = cb11[4].y;
  r3.xy = r3.xx ? r4.xy : r5.xy;
  r2.xy = r2.xy * r2.xy;
  r2.x = dot(r2.xyz, cb11[5].xyz);
  r2.yz = r3.yy * r2.xw;
  r3.y = dot(v4.xyz, v4.xyz);
  r3.y = rsqrt(r3.y);
  r4.xyz = v4.xyz * r3.yyy;
  r3.z = cmp(0 < cb11[0].w);
  if (r3.z != 0) {
    r4.x = saturate(dot(r1.yzw, r4.xyz));
    r4.y = 0;
    r4.xyz = t5.Sample(s5_s, r4.xy).xyz;
  } else {
    r4.xyz = cb11[0].xyz;
  }
  r3.z = dot(r4.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r5.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r4.xyyz;
  r5.xyzw = cmp(r4.yxzy < r5.xyzw);
  r3.w = r5.y ? r5.x : 0;
  r3.w = r5.z ? r3.w : 0;
  r3.w = r5.w ? r3.w : 0;
  r4.w = cmp(0.779999971 < r3.z);
  r3.w = r4.w ? r3.w : 0;
  r5.xyz = float3(0.796000004,0.796000004,0.796000004) * r4.xyz;
  r4.xyz = r3.www ? r5.xyz : r4.xyz;
  r0.xyz = r4.xyz * r0.xyz;
  r0.xyzw = v3.xxxw * r0.xyzw;
  r4.xy = cb2[12].zy * v3.xx;
  r3.w = saturate(cb3[49].w + cb2[13].z);
  r5.y = r4.y * r3.w;
  r2.y = v3.x * r2.y;
  r2.y = r3.x * r2.y;
  r3.xw = -cb11[2].zz + float2(1,2);
  r4.y = v3.z * r3.x;
  r6.xyz = v1.xyy * r3.www;
  r7.xyz = t3.Sample(s3_s, r6.xz).xyz;
  r3.w = t3.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r4.z = cmp(0.49000001 < r3.w);
  r3.w = cmp(r3.w < 0.50999999);
  r3.w = r3.w ? r4.z : 0;
  r4.z = saturate(cb11[2].y * 2.5 + -1.5);
  r4.w = r7.x * r4.z;
  r8.y = 1.29999995 * r4.w;
  r8.z = r7.y;
  r8.yz = r3.ww ? r8.yz : r7.yz;
  r4.w = t3.Sample(s3_s, r6.xz, int2(0, 0)).x;
  r5.z = t3.Sample(s3_s, r6.xz, int2(0, 0)).x;
  r5.w = t3.Sample(s3_s, r6.xz, int2(0, 0)).x;
  r6.w = t3.Sample(s3_s, r6.xz, int2(0, 0)).x;
  r4.w = 0.333333313 * r4.w;
  r5.zw = float2(0.333333313,0.333333313) * r5.zw;
  r6.w = 0.333333313 * r6.w;
  r3.z = -0.0170000009 + r3.z;
  r7.y = dot(cb11[3].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r3.z = cmp(r3.z < r7.y);
  r4.w = r3.z ? r4.w : -r4.w;
  r5.zw = r3.zz ? r5.zw : -r5.zw;
  r3.z = r3.z ? r6.w : -r6.w;
  r3.z = r3.z + -r5.w;
  r9.x = r3.z + r3.z;
  r3.z = r5.z + -r4.w;
  r9.y = r3.z + r3.z;
  r3.z = -r9.x * r9.x + 1;
  r3.z = -r9.y * r9.y + r3.z;
  r9.z = sqrt(r3.z);
  r7.yzw = max(float3(-1,-1,-1), r9.xyz);
  r7.yzw = min(float3(1,1,1), r7.yzw);
  r9.xyz = -cb3[0].xyz + float3(0,0,-1);
  r9.xyz = cb11[6].www * r9.xyz + cb3[0].xyz;
  r10.xyz = v4.xyz * r3.yyy + -r9.xyz;
  r3.y = dot(r10.xyz, r10.xyz);
  r3.y = rsqrt(r3.y);
  r11.xyz = r10.xyz * r3.yyy;
  r10.xyz = -r10.xyz * r3.yyy + float3(1,1,1);
  r10.xyz = sqrt(r10.xyz);
  r3.y = dot(r7.yzw, r10.xyz);
  r3.z = r7.x * r3.y;
  r4.w = cb11[2].z * cb5[3].z;
  r3.y = -r7.x * r3.y + r8.z;
  r8.x = r4.w * r3.y + r3.z;
  r3.yz = cb11[2].xx * r8.xy;
  r4.w = v3.z * r3.x + -1;
  r3.x = r3.x * r4.w + 1;
  r3.y = r3.y * r3.x;
  r7.xyz = cb11[3].xyz * cb11[2].yyy;
  r7.xyz = r7.xyz * float3(1.07558298,0.994183481,0.930233717) + -r0.xyz;
  r0.xyz = r3.yyy * r7.xyz + r0.xyz;
  r3.y = cb11[2].x * r4.y;
  r7.xyz = r8.zzz + -r0.xyz;
  r0.xyz = r3.yyy * r7.xyz + r0.xyz;
  r3.x = -r3.z * r3.x + 1;
  r7.x = r3.x * r2.y;
  r3.y = cb11[2].w * v3.x;
  r2.x = r3.y * r2.x;
  r2.x = 0.75 * r2.x;
  r3.y = cmp(1.5 < abs(cb11[0].w));
  if (r3.y != 0) {
    r8.x = saturate(dot(r1.yzw, -r9.xyz));
    r8.y = 0;
    r8.xyz = t14.Sample(s14_s, r8.xy).xyz;
  } else {
    r8.xyz = cb11[6].xyz;
  }
  r8.xyz = r8.xyz * r2.xxx;
  r2.x = dot(r1.yzw, r11.xyz);
  r2.x = saturate(9.99999994e-09 + r2.x);
  r2.w = r2.w * 15 + 9.99999994e-09;
  r2.x = log2(r2.x);
  r2.x = r2.w * r2.x;
  r2.x = exp2(r2.x);
  r0.xyz = r8.xyz * r2.xxx + r0.xyz;
  r0.xyz = min(float3(240,240,240), r0.xyz);
  r8.w = cb2[12].x * r0.w;
  r1.yzw = r1.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = cmp(cb11[2].y < 1);
  r0.w = r0.w ? r3.w : 0;
  if (r0.w != 0) {
    r2.xw = cmp(r6.xz < float2(0.400000006,0.649999976));
    r0.w = r2.w ? r2.x : 0;
    r2.x = r0.w ? -1 : 1;
    r2.x = cb2[13].x * r2.x;
    r2.xw = -r2.xx * float2(4.8599999e-05,4.8599999e-05) + r6.xz;
    r2.xw = float2(7.69999981,7.69999981) * r2.xw;
    r3.yz = t3.Sample(s3_s, r2.xw).zw;
    r2.x = dot(r3.yz, r3.yz);
    r2.x = min(1, r2.x);
    r3.w = 1 + -r2.x;
    r2.x = dot(r3.yzw, r3.yzw);
    r2.x = sqrt(r2.x);
    r3.yzw = r2.xxx * r1.yzw;
    r9.xyz = float3(1.097,1.097,1.097) * r3.yzw;
    r6.xyz = r6.xyz * float3(2,2,2) + float3(-1,-1,-1);
    r6.xyz = float3(3.20000005,3.20000005,-2.4000001) * r6.xyz;
    r6.w = -r6.y;
    r6.xy = r0.ww ? r6.zz : r6.xw;
    r2.x = cb2[13].x * 0.0109350001;
    r2.w = cb2[13].x * 0.0109350001 + r6.y;
    r10.xyz = float3(12,24,22.2000008) * r6.xyx;
    r4.yw = floor(r10.xz);
    r4.yw = float2(12345.5596,12345.5596) * r4.yw;
    r4.yw = sin(r4.yw);
    r4.yw = float2(7658.75977,7658.75977) * r4.yw;
    r4.yw = frac(r4.yw);
    r6.z = r4.y + r2.w;
    r11.xyzw = float4(12,2,2,44.4000015) * r6.xzzy;
    r5.zw = floor(r11.xz);
    r2.w = dot(r5.zw, float2(35.2000008,2376.1001));
    r10.xzw = float3(0.103100002,0.113689996,0.137869999) * r2.www;
    r10.xzw = frac(r10.xzw);
    r12.xyz = float3(19.1900005,19.1900005,19.1900005) + r10.zwx;
    r2.w = dot(r10.xzw, r12.xyz);
    r10.xzw = r10.xzw + r2.www;
    r5.zw = r10.xz + r10.zw;
    r5.zw = r5.zw * r10.wx;
    r5.zw = frac(r5.zw);
    r10.xzw = frac(r11.xyz);
    r11.xy = float2(-0.5,-0.5) + r5.zw;
    r2.w = sin(r10.y);
    r4.y = 0.5 + -abs(r11.x);
    r2.w = r4.y * r2.w;
    r2.w = r2.w * r11.y + r11.x;
    r4.y = cb2[13].x * 0.0145800002 + r5.w;
    r4.y = frac(r4.y);
    r5.z = 1.17647099 * r4.y;
    r5.z = min(1, r5.z);
    r5.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r5.w * r5.z;
    r4.y = -1 + r4.y;
    r4.y = -6.66666794 * r4.y;
    r4.y = min(1, r4.y);
    r5.w = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r5.w * r4.y;
    r4.y = r5.z * r4.y + -0.5;
    r5.zw = r4.yy * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r10.xyz = float3(-0.5,-0,-1) + r10.xzw;
    r4.y = 1 / r5.w;
    r4.y = saturate(r10.z * r4.y);
    r5.w = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r5.w * r4.y;
    r4.y = sqrt(r4.y);
    r5.w = r5.z + r5.z;
    r5.w = 1 / r5.w;
    r5.w = r10.y * r5.w;
    r5.w = min(1, r5.w);
    r6.z = r5.w * -2 + 3;
    r5.w = r5.w * r5.w;
    r5.w = r6.z * r5.w;
    r5.w = sqrt(r5.w);
    r4.y = r5.w * r4.y;
    r5.w = 0.379999995 * r4.y;
    r6.z = r4.y * r4.y;
    r2.w = -r2.w * 0.699999988 + r10.x;
    r5.w = r6.z * 0.150000006 + -r5.w;
    r2.w = -r4.y * 0.379999995 + abs(r2.w);
    r4.y = 1 / r5.w;
    r2.w = saturate(r4.y * r2.w);
    r4.y = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r4.y * r2.w;
    r4.y = r10.y + -r5.z;
    r4.y = 1 + r4.y;
    r4.y = saturate(0.980392218 * r4.y);
    r5.z = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r5.z * r4.y;
    r2.w = r4.y * r2.w;
    r2.x = r6.y * 1.85000002 + r2.x;
    r6.w = r2.x + r4.w;
    r6.xyz = float3(22.2000008,2,2) * r6.xww;
    r4.yw = floor(r6.xz);
    r2.x = dot(r4.yw, float2(35.2000008,2376.1001));
    r10.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.xxx;
    r10.xyz = frac(r10.xyz);
    r11.xyz = float3(19.1900005,19.1900005,19.1900005) + r10.yzx;
    r2.x = dot(r10.xyz, r11.xyz);
    r10.xyz = r10.xyz + r2.xxx;
    r4.yw = r10.xy + r10.yz;
    r4.yw = r4.yw * r10.zx;
    r4.yw = frac(r4.yw);
    r6.xyz = frac(r6.xyz);
    r5.zw = float2(-0.5,-0.5) + r4.yw;
    r2.x = sin(r11.w);
    r4.y = 0.5 + -abs(r5.z);
    r2.x = r4.y * r2.x;
    r2.x = r2.x * r5.w + r5.z;
    r4.y = cb2[13].x * 0.0145800002 + r4.w;
    r4.y = frac(r4.y);
    r4.w = 1.17647099 * r4.y;
    r4.w = min(1, r4.w);
    r5.z = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.z * r4.w;
    r4.y = -1 + r4.y;
    r4.y = -6.66666794 * r4.y;
    r4.y = min(1, r4.y);
    r5.z = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r5.z * r4.y;
    r4.y = r4.w * r4.y + -0.5;
    r4.yw = r4.yy * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r6.xyz = float3(-0.5,-0,-1) + r6.xyz;
    r4.w = 1 / r4.w;
    r4.w = saturate(r6.z * r4.w);
    r5.z = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.z * r4.w;
    r4.w = sqrt(r4.w);
    r5.z = r4.y + r4.y;
    r5.z = 1 / r5.z;
    r5.z = r6.y * r5.z;
    r5.z = min(1, r5.z);
    r5.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r5.w * r5.z;
    r5.z = sqrt(r5.z);
    r4.w = r5.z * r4.w;
    r5.z = 0.379999995 * r4.w;
    r5.w = r4.w * r4.w;
    r2.x = -r2.x * 0.699999988 + r6.x;
    r5.z = r5.w * 0.150000006 + -r5.z;
    r2.x = -r4.w * 0.379999995 + abs(r2.x);
    r4.w = 1 / r5.z;
    r2.x = saturate(r4.w * r2.x);
    r4.w = r2.x * -2 + 3;
    r2.x = r2.x * r2.x;
    r2.x = r4.w * r2.x;
    r4.y = r6.y + -r4.y;
    r4.y = 1 + r4.y;
    r4.y = saturate(0.980392218 * r4.y);
    r4.w = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r4.w * r4.y;
    r2.x = r4.y * r2.x;
    r2.x = max(r2.w, r2.x);
    r2.x = min(1, r2.x);
    r3.yzw = -r3.yzw * float3(1.097,1.097,1.097) + r1.yzw;
    r3.yzw = r2.xxx * r3.yzw + r9.xyz;
    r0.w = r0.w ? 0.003900 : 0;
    r0.w = r2.x * r0.w + 1;
    r6.xyz = -r3.yzw + r1.yzw;
    r1.yzw = r4.zzz * r6.xyz + r3.yzw;
  } else {
    r0.w = 1;
  }
  r3.yzw = float3(256,256,256) * r1.zyw;
  r3.yzw = floor(r3.zyw);
  r1.yzw = r1.zyw * float3(256,256,256) + -r3.zyw;
  r1.yzw = float3(8,8,4) * r1.yzw;
  r1.yzw = floor(r1.yzw);
  r1.y = dot(r1.yzw, float3(4,32,1));
  o1.w = 0.00392156886 * r1.y;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.yzw;
  r7.y = 0.001953125 * r2.z;
  r5.x = cb2[12].z * v3.x + cb3[45].w;
  r1.yz = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r1.yz);
  r1.x = v2.z * r1.x + -0.349999994;
  r1.x = saturate(1.53846204 * r1.x);
  r1.x = cb5[3].z * r1.x;
  r1.y = -cb2[13].z + 1;
  r1.x = r1.y * r1.x;
  r1.x = r1.x * r4.x;
  r1.y = r7.x * -0.5 + 1;
  r1.y = r1.y * r1.x;
  r1.y = r1.y * -0.5 + 1;
  r8.xyz = r1.yyy * r0.xyz;
  r0.x = saturate(r3.x * r2.y + 0.400000006);
  r7.z = cb11[3].w * r0.w;
  r0.xy = r0.xx * float2(0.5,0.48828131) + -r7.xy;
  r0.xy = max(float2(0,0), r0.xy);
  r0.z = 0;
  r0.xyz = r0.xyz * r1.xxx + r7.xyz;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r8.xyzw;
  o2.z = r0.z;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}