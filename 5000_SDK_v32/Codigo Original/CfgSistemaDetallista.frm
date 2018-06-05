[Forma]
Clave=CfgSistemaDetallista
Nombre=Configuración - Sistema Detallista
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=258
PosicionInicialArriba=366
PosicionInicialAlturaCliente=264
PosicionInicialAncho=764
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgSistemaDetallista
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=CfgSistemaDetallista.Orden<TAB>(Acendente)
CarpetaVisible=S

[Lista.CfgSistemaDetallista.Concepto]
Carpeta=Lista
Clave=CfgSistemaDetallista.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CfgSistemaDetallista.CuentaCosto]
Carpeta=Lista
Clave=CfgSistemaDetallista.CuentaCosto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CfgSistemaDetallista.CuentaPrecio]
Carpeta=Lista
Clave=CfgSistemaDetallista.CuentaPrecio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=146
CuentaCosto=124
CuentaPrecio=124
Descripcion=159
Descripcion_1=179

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.CtaDestino.Descripcion]
Carpeta=Lista
Clave=CtaDestino.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaEnCaptura]
(Inicio)=CfgSistemaDetallista.Concepto
CfgSistemaDetallista.Concepto=CfgSistemaDetallista.CuentaCosto
CfgSistemaDetallista.CuentaCosto=Cta.Descripcion
Cta.Descripcion=CfgSistemaDetallista.CuentaPrecio
CfgSistemaDetallista.CuentaPrecio=CtaDestino.Descripcion
CtaDestino.Descripcion=(Fin)
