[Forma]
Clave=OportunidadCampos
Nombre=Info.Mov+<T> <T>+Info.MovID
Icono=4
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
PosicionInicialIzquierda=405
PosicionInicialArriba=248
PosicionInicialAltura=234
PosicionInicialAncho=397
PosicionInicialAlturaCliente=193

MovModulo=OPORT
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OportunidadCampos
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

FiltroGeneral=Oportunidad.ID={Info.ID}
[Ficha.Oportunidad.Concepto]
Carpeta=Ficha
Clave=Oportunidad.Concepto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Oportunidad.Referencia]
Carpeta=Ficha
Clave=Oportunidad.Referencia
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

[Ficha.Oportunidad.Observaciones]
Carpeta=Ficha
Clave=Oportunidad.Observaciones
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco


[Ficha.Oportunidad.Proyecto]
Carpeta=Ficha
Clave=Oportunidad.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Oportunidad.UEN]
Carpeta=Ficha
Clave=Oportunidad.UEN
Editar=S
3D=S
Tamano=9
ColorFondo=Blanco
EditarConBloqueo=S






[Ficha.Oportunidad.NivelInteres]
Carpeta=Ficha
Clave=Oportunidad.NivelInteres
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco



EditarConBloqueo=S
[Ficha.ListaEnCaptura]
(Inicio)=Oportunidad.Proyecto
Oportunidad.Proyecto=Oportunidad.UEN
Oportunidad.UEN=Oportunidad.Concepto
Oportunidad.Concepto=Oportunidad.Referencia
Oportunidad.Referencia=Oportunidad.Observaciones
Oportunidad.Observaciones=Oportunidad.NivelInteres
Oportunidad.NivelInteres=(Fin)
