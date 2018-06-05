
[Forma]
Clave=MFATipoCtaImpuesto
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=MFA - Configuración cuentas contables impuestos

ListaCarpetas=Lista
PosicionInicialAlturaCliente=366
PosicionInicialAncho=606
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=337
PosicionInicialArriba=170
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFATipoCtaImpuesto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Registros

Filtros=S
FiltroPredefinido=S
FiltroAutoCampo=MFATipoCtaImpuesto.ImpuestoTipo
FiltroAutoValidar=MFATipoCtaImpuesto.ImpuestoTipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Folder (1 línea)
FiltroRespetar=S
FiltroTipo=Automático
[Lista.MFATipoCtaImpuesto.Modulo]
Carpeta=Lista
Clave=MFATipoCtaImpuesto.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MFATipoCtaImpuesto.Mov]
Carpeta=Lista
Clave=MFATipoCtaImpuesto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFATipoCtaImpuesto.Minimo]
Carpeta=Lista
Clave=MFATipoCtaImpuesto.Minimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFATipoCtaImpuesto.Maximo]
Carpeta=Lista
Clave=MFATipoCtaImpuesto.Maximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFATipoCtaImpuesto.ImpuestoTipo]
Carpeta=Lista
Clave=MFATipoCtaImpuesto.ImpuestoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFATipoCtaImpuesto.Cuenta]
Carpeta=Lista
Clave=MFATipoCtaImpuesto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Modulo=64
Mov=124
Minimo=64
Maximo=64
ImpuestoTipo=124
Cuenta=124

0=207

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.ListaEnCaptura]
(Inicio)=MFATipoCtaImpuesto.Modulo
MFATipoCtaImpuesto.Modulo=MFATipoCtaImpuesto.Mov
MFATipoCtaImpuesto.Mov=MFATipoCtaImpuesto.Minimo
MFATipoCtaImpuesto.Minimo=MFATipoCtaImpuesto.Maximo
MFATipoCtaImpuesto.Maximo=MFATipoCtaImpuesto.ImpuestoTipo
MFATipoCtaImpuesto.ImpuestoTipo=MFATipoCtaImpuesto.Cuenta
MFATipoCtaImpuesto.Cuenta=(Fin)
