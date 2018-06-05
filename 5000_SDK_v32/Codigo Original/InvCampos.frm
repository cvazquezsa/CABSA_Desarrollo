[Forma]
Clave=InvCampos
Nombre=Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=466
PosicionInicialArriba=245
PosicionInicialAltura=142
PosicionInicialAncho=434
PosicionInicialAlturaCliente=198

[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=InvCampos
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=Inv.ID={Info.ID}
[Ficha.Inv.Concepto]
Carpeta=Ficha
Clave=Inv.Concepto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Inv.Referencia]
Carpeta=Ficha
Clave=Inv.Referencia
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

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

[Ficha.Inv.Observaciones]
Carpeta=Ficha
Clave=Inv.Observaciones
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Inv.Proyecto]
Carpeta=Ficha
Clave=Inv.Proyecto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Inv.UEN]
Carpeta=Ficha
Clave=Inv.UEN
Editar=S
EditarConBloqueo=S
3D=S
Tamano=9
ColorFondo=Blanco




[Ficha.Inv.Almacen]
Carpeta=Ficha
Clave=Inv.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Inv.PosicionWMS]
Carpeta=Ficha
Clave=Inv.PosicionWMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=Inv.Proyecto
Inv.Proyecto=Inv.UEN
Inv.UEN=Inv.Concepto
Inv.Concepto=Inv.Referencia
Inv.Referencia=Inv.Observaciones
Inv.Observaciones=Inv.Almacen
Inv.Almacen=Inv.PosicionWMS
Inv.PosicionWMS=(Fin)
