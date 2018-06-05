[Forma]
Clave=VentaEntrega
Nombre=Datos Entrega
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=671
PosicionInicialArriba=386
PosicionInicialAlturaCliente=244
PosicionInicialAncho=337
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Mov, Info.MovID)
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
Vista=VentaEntrega
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
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
FiltroGeneral=VentaEntrega.ID={Info.ID}

[Ficha.VentaEntrega.Embarque]
Carpeta=Ficha
Clave=VentaEntrega.Embarque
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaEntrega.EmbarqueFecha]
Carpeta=Ficha
Clave=VentaEntrega.EmbarqueFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaEntrega.EmbarqueReferencia]
Carpeta=Ficha
Clave=VentaEntrega.EmbarqueReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaEntrega.Recibo]
Carpeta=Ficha
Clave=VentaEntrega.Recibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaEntrega.ReciboFecha]
Carpeta=Ficha
Clave=VentaEntrega.ReciboFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaEntrega.ReciboReferencia]
Carpeta=Ficha
Clave=VentaEntrega.ReciboReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
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

[Ficha.VentaEntrega.EntregaMercancia]
Carpeta=Ficha
Clave=VentaEntrega.EntregaMercancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CteEntregaMercancia.Nombre]
Carpeta=Ficha
Clave=CteEntregaMercancia.Nombre
3D=S
Tamano=19
ColorFondo=Plata
ColorFuente=Negro
Editar=S

[Ficha.ListaEnCaptura]
(Inicio)=VentaEntrega.Embarque
VentaEntrega.Embarque=VentaEntrega.EmbarqueFecha
VentaEntrega.EmbarqueFecha=VentaEntrega.EmbarqueReferencia
VentaEntrega.EmbarqueReferencia=VentaEntrega.EntregaMercancia
VentaEntrega.EntregaMercancia=CteEntregaMercancia.Nombre
CteEntregaMercancia.Nombre=VentaEntrega.Recibo
VentaEntrega.Recibo=VentaEntrega.ReciboFecha
VentaEntrega.ReciboFecha=VentaEntrega.ReciboReferencia
VentaEntrega.ReciboReferencia=(Fin)
