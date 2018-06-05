[Forma]
Clave=CfgRegistroCuenta
Nombre=Configuración del Registro - Cuentas Contables
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Numero, Info.Nombre)
PosicionInicialIzquierda=352
PosicionInicialArriba=247
PosicionInicialAlturaCliente=495
PosicionInicialAncho=575
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgRegistroCuenta
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CfgRegistroCuenta.CfgRegistro={Info.Numero}

[Lista.CfgRegistroCuenta.Referencia]
Carpeta=Lista
Clave=CfgRegistroCuenta.Referencia
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.CfgRegistroCuenta.Cuenta]
Carpeta=Lista
Clave=CfgRegistroCuenta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Columnas]
Referencia=186
Cuenta=111
Descripcion=246

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

[Lista.ListaEnCaptura]
(Inicio)=CfgRegistroCuenta.Referencia
CfgRegistroCuenta.Referencia=CfgRegistroCuenta.Cuenta
CfgRegistroCuenta.Cuenta=Cta.Descripcion
Cta.Descripcion=(Fin)
