[Forma]
Clave=CompraCampos
Nombre=Info.Mov+<T> <T>+Info.MovID
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
ListaAcciones=Aceptar
PosicionInicialIzquierda=481
PosicionInicialArriba=187
PosicionInicialAltura=234
PosicionInicialAncho=403
PosicionInicialAlturaCliente=314

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraCampos
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=Compra.ID={Info.ID}
[Ficha.Compra.Concepto]
Carpeta=Ficha
Clave=Compra.Concepto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Compra.Referencia]
Carpeta=Ficha
Clave=Compra.Referencia
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Compra.FechaEntrega]
Carpeta=Ficha
Clave=Compra.FechaEntrega
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Ficha.Compra.Condicion]
Carpeta=Ficha
Clave=Compra.Condicion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Editar=S

[Ficha.Compra.Vencimiento]
Carpeta=Ficha
Clave=Compra.Vencimiento
Editar=S
EditarConBloqueo=S
3D=S
Tamano=19
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

[Ficha.Compra.Observaciones]
Carpeta=Ficha
Clave=Compra.Observaciones
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Compra.Causa]
Carpeta=Ficha
Clave=Compra.Causa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Compra.Proyecto]
Carpeta=Ficha
Clave=Compra.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Compra.UEN]
Carpeta=Ficha
Clave=Compra.UEN
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Compra.Prioridad]
Carpeta=Ficha
Clave=Compra.Prioridad
Editar=S
EditarConBloqueo=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=19
ColorFondo=Blanco

[Ficha.Compra.FormaEntrega]
Carpeta=Ficha
Clave=Compra.FormaEntrega
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco








[Ficha.Compra.Almacen]
Carpeta=Ficha
Clave=Compra.Almacen
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Compra.PosicionWMS]
Carpeta=Ficha
Clave=Compra.PosicionWMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Ficha.ListaEnCaptura]
(Inicio)=Compra.Proyecto
Compra.Proyecto=Compra.UEN
Compra.UEN=Compra.Concepto
Compra.Concepto=Compra.Referencia
Compra.Referencia=Compra.Causa
Compra.Causa=Compra.Observaciones
Compra.Observaciones=Compra.FormaEntrega
Compra.FormaEntrega=Compra.FechaEntrega
Compra.FechaEntrega=Compra.Prioridad
Compra.Prioridad=Compra.Condicion
Compra.Condicion=Compra.Vencimiento
Compra.Vencimiento=Compra.Almacen
Compra.Almacen=Compra.PosicionWMS
Compra.PosicionWMS=(Fin)
