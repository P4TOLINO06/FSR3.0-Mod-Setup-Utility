// ---- FNV Hash fea728491ae0dffe

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer ssao_locals : register(b12)
{
  float4 g_projParams : packoffset(c0);
  float4 gNormalOffset : packoffset(c1);
  float4 gOffsetScale0 : packoffset(c2);
  float4 gOffsetScale1 : packoffset(c3);
  float g_SSAOStrength : packoffset(c4);
  float4 g_CPQSMix_QSFadeIn : packoffset(c5);
  float4 TargetSizeParam : packoffset(c6);
  float4 FallOffAndKernelParam : packoffset(c7);
  float4 g_MSAAPointTexture1_Dim : packoffset(c8);
  float4 g_MSAAPointTexture2_Dim : packoffset(c9);
  float4 gExtraParams0 : packoffset(c10);
  float4 gExtraParams1 : packoffset(c11);
  float4 gExtraParams2 : packoffset(c12);
  float4 gExtraParams3 : packoffset(c13);
  float4 gExtraParams4 : packoffset(c14);
  float3 gPerspectiveShearParams0 : packoffset(c15);
  float3 gPerspectiveShearParams1 : packoffset(c16);
  float3 gPerspectiveShearParams2 : packoffset(c17);
  row_major float4x4 gPrevViewProj : packoffset(c18);
}

SamplerState MSAAPointSampler1_s : register(s4);
SamplerState PointSampler2_s : register(s6);
Texture2D<float4> MSAAPointTexture1 : register(t4);
Texture2D<float4> PointSampler2 : register(t6);
Texture2D<uint2> StencilCopyTexture : register(t14);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0,0.5) * globalScreenSize.zw;
  r0.zw = globalScreenSize.xy * v1.xy;
  r0.zw = r0.zw + r0.zw;
  r0.zw = floor(r0.zw);
  r0.z = dot(r0.zw, float2(0.5,0.5));
  r0.z = frac(r0.z);
  r0.z = cmp(r0.z < 0.5);
  r0.xy = r0.zz ? r0.xy : 0;
  r0.xy = v1.xy + r0.xy;
  r1.xyzw = MSAAPointTexture1.SampleLevel(MSAAPointSampler1_s, r0.xy, 0).xyzw;
  r1.xyz = r1.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.x = dot(gViewInverse._m00_m01_m02, r1.xyz);
  r2.y = dot(gViewInverse._m10_m11_m12, r1.xyz);
  r2.z = dot(gViewInverse._m20_m21_m22, r1.xyz);
  r0.zw = globalScreenSize.zw * float2(-0.5,-0.5) + r0.xy;
  r1.xyzw = globalScreenSize.zwzw * float4(0.5,-0.5,-0.5,0.5) + r0.xyxy;
  r0.xy = globalScreenSize.zw * float2(0.5,0.5) + r0.xy;
  r0.xyzw = globalScreenSize.xyxy * r0.xyzw;
  r0.xyzw = r0.xyzw + r0.xyzw;
  r3.xy = (int2)r0.zw;
  r3.zw = float2(0,0);
  r3.xy = StencilCopyTexture.Load(r3.xyz).xy;
  r1.xyzw = globalScreenSize.xyxy * r1.xyzw;
  r1.xyzw = r1.xyzw + r1.xyzw;
  r1.xyzw = (int4)r1.zwxy;
  r4.xy = r1.zw;
  r4.zw = float2(0,0);
  r4.xy = StencilCopyTexture.Load(r4.xyz).xy;
  r1.zw = float2(0,0);
  r1.xy = StencilCopyTexture.Load(r1.xyz).xy;
  r0.xy = (int2)r0.xy;
  r0.zw = float2(0,0);
  r0.xy = StencilCopyTexture.Load(r0.xyz).xy;
  r3.y = r4.x;
  r3.z = r1.x;
  r3.w = r0.x;
  r0.xyzw = cmp((int4)r3.xyzw == int4(7,7,7,7));
  r0.xyzw = r0.xyzw ? float4(1,1,1,1) : 0;
  r0.x = dot(r0.xyzw, float4(0.25,0.25,0.25,0.25));
  r0.x = cmp(0 >= r0.x);
  r0.y = dot(v1.xy, float2(25.9796009,156.466003));
  r0.y = sin(r0.y);
  r0.y = 43758.5469 * r0.y;
  r0.y = frac(r0.y);
  r1.xyzw = gExtraParams0.zzzz * globalScreenSize.zwzw;
  r1.xyzw = float4(16,16,16,16) * r1.xyzw;
  r2.xyz = float3(1,-1,-1) * r2.xyz;
  r0.z = 0.449999988 + r0.y;
  r0.z = 3.14199996 * r0.z;
  sincos(r0.z, r4.x, r5.x);
  r4.xz = r4.xx;
  r4.yw = r5.xx;
  r4.xyzw = r4.xyzw * r1.xyzw;
  r1.xyzw = r2.xyxy * r1.xyzw + v1.xyxy;
  r5.xyzw = r4.zwzw * float4(0.5,-1,-1,-0.5) + r1.zwzw;
  r1.xyzw = r4.xyzw * float4(-0.5,1,1,0.5) + r1.xyzw;
  r4.xyzw = PointSampler2.Sample(PointSampler2_s, r5.xy).xyzw;
  r6.xyzw = PointSampler2.Sample(PointSampler2_s, r5.zw).xyzw;
  r7.xyzw = PointSampler2.Sample(PointSampler2_s, r1.xy).xyzw;
  r8.xyzw = PointSampler2.Sample(PointSampler2_s, r1.zw).yzwx;
  if (r0.x != 0) {
    r9.xyzw = PointSampler2.SampleLevel(PointSampler2_s, v1.xy, 0).xyzw;
    r0.xz = v1.xy * float2(2,-2) + float2(-1,1);
    r10.xy = g_projParams.xy * r0.xz;
    r10.z = 1;
    r0.xzw = r10.xyz * r9.xxx;
    r3.xyzw = cmp((int4)r3.xyzw == int4(3,3,3,3));
    r3.xyzw = r3.xyzw ? float4(1,1,1,1) : 0;
    r2.w = dot(r3.xyzw, float4(0.25,0.25,0.25,0.25));
    r3.x = saturate(gExtraParams0.w * r0.w);
    r3.y = gExtraParams0.y + -gExtraParams0.x;
    r3.x = r3.x * r3.y + gExtraParams0.x;
    r3.y = r3.x * r3.x;
    sincos(r0.y, r11.x, r12.x);
    r3.x = g_projParams.x * r3.x;
    r3.x = 0.5 * r3.x;
    r3.x = r3.x / r0.w;
    r3.x = globalScreenSize.x * r3.x;
    r13.x = min(6, r3.x);
    r3.z = 1 + r13.x;
    r13.y = r3.x / r3.z;
    r3.z = gExtraParams1.z / r13.y;
    r3.w = cmp(r3.z < r13.x);
    r3.z = r3.z + r0.y;
    r3.z = floor(r3.z);
    r14.x = max(1, r3.z);
    r14.y = gExtraParams1.z / r14.x;
    r3.zw = r3.ww ? r14.xy : r13.xy;
    r4.yz = globalScreenSize.zw * r3.ww;
    r13.x = globalScreenSize.z;
    r13.yw = float2(0,0);
    r6.yz = v1.xy + r13.xy;
    r14.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r6.yz, 0).xyzw;
    r6.yz = r6.yz * float2(2,-2) + float2(-1,1);
    r15.xy = g_projParams.xy * r6.yz;
    r15.z = 1;
    r3.w = r15.z * r14.x;
    r13.z = -globalScreenSize.z;
    r6.yz = v1.xy + r13.zw;
    r13.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r6.yz, 0).xyzw;
    r6.yz = r6.yz * float2(2,-2) + float2(-1,1);
    r16.xy = g_projParams.xy * r6.yz;
    r16.z = 1;
    r6.yzw = r16.xyz * r13.xxx;
    r13.xz = float2(0,0);
    r13.y = globalScreenSize.w;
    r7.yz = v1.xy + r13.xy;
    r16.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r7.yz, 0).xyzw;
    r7.yz = r7.yz * float2(2,-2) + float2(-1,1);
    r17.xy = g_projParams.xy * r7.yz;
    r17.z = 1;
    r18.w = r17.z * r16.x;
    r13.w = -globalScreenSize.w;
    r7.yz = v1.xy + r13.zw;
    r13.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r7.yz, 0).xyzw;
    r7.yz = r7.yz * float2(2,-2) + float2(-1,1);
    r19.xy = g_projParams.xy * r7.yz;
    r19.z = 1;
    r18.xyz = r19.xyz * r13.xxx;
    r7.yzw = r15.xyz * r14.xxx + -r0.xzw;
    r9.yzw = r10.xyz * r9.xxx + -r6.yzw;
    r4.w = dot(r7.yzw, r7.yzw);
    r6.y = dot(r9.yzw, r9.yzw);
    r4.w = cmp(r4.w < r6.y);
    r7.yzw = r4.www ? r7.yzw : r9.yzw;
    r9.yzw = r17.xyz * r16.xxx + -r0.xzw;
    r10.xyw = r10.xyz * r9.xxx + -r18.xyz;
    r4.w = dot(r9.yzw, r9.yzw);
    r6.y = dot(r10.xyw, r10.xyw);
    r4.w = cmp(r4.w < r6.y);
    r9.yzw = r4.www ? r9.yzw : r10.xyw;
    r4.w = globalScreenSize.y * globalScreenSize.z;
    r9.yzw = r9.yzw * r4.www;
    r4.w = 1 / r3.y;
    r13.z = 1;
    r6.yz = float2(0,0);
    while (true) {
      r10.x = cmp(r6.z >= 3);
      if (r10.x != 0) break;
      r10.x = 2.09439516 * r6.z;
      sincos(r10.x, r10.x, r14.x);
      r10.y = r10.x * r11.x;
      r15.x = r14.x * r12.x + -r10.y;
      r10.x = r10.x * r12.x;
      r15.y = r14.x * r11.x + r10.x;
      r10.xy = r15.xy * r4.yz;
      r11.yz = r10.xy * r0.yy;
      r11.yz = globalScreenSize.xy * r11.yz;
      r11.yz = round(r11.yz);
      r11.yz = r11.yz * globalScreenSize.zw + v1.xy;
      r10.xy = globalScreenSize.xy * r10.xy;
      r10.xy = round(r10.xy);
      r12.yz = globalScreenSize.zw * r10.xy;
      r14.xyz = r12.zzz * r9.yzw;
      r12.yzw = r12.yyy * r7.yzw + r14.xyz;
      r10.w = dot(r12.yz, r12.yz);
      r10.w = rsqrt(r10.w);
      r10.w = -r12.w * r10.w + gExtraParams2.y;
      r11.w = r10.w * r10.w + 1;
      r11.w = sqrt(r11.w);
      r11.w = r10.w / r11.w;
      r12.yz = r11.yz;
      r12.w = 0;
      r13.w = r10.w;
      r14.x = r11.w;
      r14.y = 1;
      while (true) {
        r14.z = cmp(r3.z < r14.y);
        if (r14.z != 0) break;
        r12.yz = r10.xy * globalScreenSize.zw + r12.yz;
        r15.xyzw = PointSampler2.SampleLevel(PointSampler2_s, r12.yz, 0).xyzw;
        r14.zw = r12.yz * float2(2,-2) + float2(-1,1);
        r13.xy = g_projParams.xy * r14.zw;
        r14.z = r15.x * r13.z;
        r14.z = r10.z * r9.x + -r14.z;
        r15.yz = r13.xy * r15.xx + -r0.xz;
        r14.w = dot(r15.yz, r15.yz);
        r14.w = rsqrt(r14.w);
        r14.z = r14.z * r14.w;
        r15.xyz = r13.xyz * r15.xxx + -r0.xzw;
        r13.x = dot(r15.xyz, r15.xyz);
        r13.y = cmp(r13.x < r3.y);
        r14.w = cmp(r13.w < r14.z);
        r13.y = r13.y ? r14.w : 0;
        if (r13.y != 0) {
          r13.y = r14.z * r14.z + 1;
          r13.y = rsqrt(r13.y);
          r14.w = r14.z * r13.y;
          r13.x = -r13.x * r4.w + 1;
          r13.x = log2(r13.x);
          r13.x = gExtraParams3.y * r13.x;
          r13.x = exp2(r13.x);
          r13.y = r14.z * r13.y + -r14.x;
          r12.w = r13.x * r13.y + r12.w;
          r13.w = r14.z;
          r14.x = r14.w;
        }
        r14.y = 1 + r14.y;
      }
      r6.y = r12.w + r6.y;
      r6.z = 1 + r6.z;
    }
    r0.x = saturate(-r2.w * gExtraParams3.x + 1);
    r0.x = gExtraParams1.x * r0.x;
    r0.x = r6.y * r0.x;
    r0.x = saturate(-r0.x * 0.333333343 + 1);
    r11.xyzw = PointSampler2.Sample(PointSampler2_s, v1.xy).xyzw;
    r0.y = 1 / r11.x;
    r8.x = r4.x;
    r8.y = r6.x;
    r8.z = r7.x;
    r4.xyzw = r8.xyzw * r0.yyyy;
    r0.yz = float2(-0.5,-0.5) + v1.xy;
    r6.xy = g_projParams.xy * r0.yz;
    r5.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r5.xyzw;
    r5.xyzw = g_projParams.xyxy * r5.zwxy;
    r7.xy = r5.zw;
    r7.z = 0.5;
    r6.z = 0.5;
    r0.yzw = r7.xyz * r4.xxx + -r6.xyz;
    r5.z = 0.5;
    r5.xyz = r5.xyz * r4.yyy + -r6.xyz;
    r1.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r1.xyzw;
    r1.xyzw = g_projParams.xyxy * r1.zwxy;
    r7.xy = r1.zw;
    r7.z = 0.5;
    r4.xyz = r7.xyz * r4.zzz + -r6.xyz;
    r1.z = 0.5;
    r1.xyz = r1.xyz * r4.www + -r6.xyz;
    r1.w = dot(r0.yzw, r0.yzw);
    r7.x = sqrt(r1.w);
    r1.w = dot(r5.xyz, r5.xyz);
    r7.y = sqrt(r1.w);
    r1.w = dot(r4.xyz, r4.xyz);
    r7.z = sqrt(r1.w);
    r1.w = dot(r1.xyz, r1.xyz);
    r7.w = sqrt(r1.w);
    r8.x = dot(r0.yzw, r2.xyz);
    r8.y = dot(r5.xyz, r2.xyz);
    r8.z = dot(r4.xyz, r2.xyz);
    r8.w = dot(r1.xyz, r2.xyz);
    r1.xyzw = float4(10,10,10,10) * r7.xyzw;
    r2.xyzw = -r8.xyzw + r7.xyzw;
    r2.xyzw = r2.xyzw / r7.xyzw;
    r1.xyzw = saturate(max(r2.xyzw, r1.xyzw));
    r0.y = dot(r1.xyzw, float4(0.25,0.25,0.25,0.25));
    r0.z = saturate(r11.x * gExtraParams4.x + gExtraParams4.y);
    r0.w = -gExtraParams3.z + gExtraParams1.y;
    r0.z = r0.z * r0.w + gExtraParams3.z;
    r0.y = log2(r0.y);
    r0.y = r0.z * r0.y;
    r0.y = exp2(r0.y);
    r18.x = r6.w;
    r18.y = r3.w;
    r1.xyzw = r10.zzzz * r9.xxxx + -r18.xyzw;
    r1.xyzw = cmp(float4(10,10,10,10) < r1.xyzw);
    r1.xyzw = r1.xyzw ? float4(1,1,1,1) : 0;
    r0.z = max(r1.z, r1.w);
    r0.z = max(r1.y, r0.z);
    r0.z = max(r1.x, r0.z);
    r0.y = max(r0.y, r0.z);
    r0.z = min(r0.x, r0.y);
    r0.x = r0.x * r0.y + -r0.z;
    r0.x = gExtraParams2.x * r0.x + r0.z;
    r0.z = saturate(gExtraParams1.w * r3.x);
    r0.x = r0.x + -r0.y;
    r0.x = r0.z * r0.x + r0.y;
  } else {
    r0.x = 1;
  }
  o0.xyzw = r0.xxxx;
  return;
}