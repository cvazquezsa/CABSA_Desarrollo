[Forma]
Clave=EmpresaCfgPuntosEnVales
Nombre=Configuración - Vales x Puntos
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=818
PosicionInicialArriba=494
PosicionInicialAlturaCliente=177
PosicionInicialAncho=284
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Empresa
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgPuntosEnVales
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaCfgPuntosEnVales.Empresa=<T>{Info.Empresa}<T>

[Ficha.EmpresaCfgPuntosEnVales.ValesMov]
Carpeta=Ficha
Clave=EmpresaCfgPuntosEnVales.ValesMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgPuntosEnVales.ValeTipo]
Carpeta=Ficha
Clave=EmpresaCfgPuntosEnVales.ValeTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgPuntosEnVales.Duracion]
Carpeta=Ficha
Clave=EmpresaCfgPuntosEnVales.Duracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgPuntosEnVales.DuracionUnidad]
Carpeta=Ficha
Clave=EmpresaCfgPuntosEnVales.DuracionUnidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EmpresaCfgPuntosEnVales.Consecutivo]
Carpeta=Ficha
Clave=EmpresaCfgPuntosEnVales.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Mov]
Nombre=Mov
Boton=47
NombreEnBoton=S
NombreDesplegar=&Movimientos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaCfgPuntosEnValesMov
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Mov
Mov=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=EmpresaCfgPuntosEnVales.ValesMov
EmpresaCfgPuntosEnVales.ValesMov=EmpresaCfgPuntosEnVales.ValeTipo
EmpresaCfgPuntosEnVales.ValeTipo=EmpresaCfgPuntosEnVales.Duracion
EmpresaCfgPuntosEnVales.Duracion=EmpresaCfgPuntosEnVales.DuracionUnidad
EmpresaCfgPuntosEnVales.DuracionUnidad=EmpresaCfgPuntosEnVales.Consecutivo
EmpresaCfgPuntosEnVales.Consecutivo=(Fin)
